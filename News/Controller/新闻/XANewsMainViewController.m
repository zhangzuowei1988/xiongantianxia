//
//  XANewsMainViewController.m
//  News
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANewsMainViewController.h"
#import "PDMITagView.h"
#import "DLCustomSlideView.h"
#import "DLLRUCache.h"
#import "DLScrollTabbarView.h"
#import "XARecommendViewController.h"
#import "XANewsListViewController.h"

#define colummViewHeight 37//选择栏的高度

@interface XANewsMainViewController ()<DLCustomSlideViewDelegate,PDMITagViewDelegate>
@property(nonatomic,strong)NSMutableArray *selectColumnArr;//已订阅的栏目
@property(nonatomic,strong)NSMutableArray *unSelectColumnArr;//未订阅的栏目
@property(nonatomic,strong)PDMITagView *tagView;
@property(nonatomic,strong)DLCustomSlideView *slideView;//滑动框架
@property(nonatomic,assign)UIStatusBarStyle statusBarStyle;
@property(nonatomic,assign)CGFloat originalHeight;

@end

@implementation XANewsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitlelabel.text = @"雄安 • 新闻";
    self.pageModel.columnList = [CommData shareInstance].getHotspotData;
    _originalHeight = self.view.height;
    if (self.pageModel.columnList==nil) {
//        [self setErrorViewWithCode:-1];
        [self reLoadRequest];
        return;
    }
    [self initArr];
    [self initColumnView];
}

/**
 如果本地没有栏目列表，从新从服务器获取
 */
- (void)reLoadRequest
{
    if (self.errorView!=nil) {
        [self.errorView setHidden:YES];
    }
    
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    //如果本地没有拿到栏目信息，重新获取
    [[NewsNetWork shareInstance] getConfigureWithComplete:^(id result) {
        [self.loadingView hide];
        self.pageModel.columnList = [CommData shareInstance].getHotspotData;
        [self initArr];
        [self initColumnView];
    } withErrorBlock:^(NSError *error) {
        [self.loadingView hide];
        [self setErrorViewWithCode:error.code];
    }];
}
#pragma mark - loadingView
-(void)setLoadingView
{
    if (!self.loadingView) {
        self.loadingView=[[JHUD alloc] initWithFrame:CGRectMake(0, self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        self.loadingView.messageLabel.text=LOADING_TITLE;
    }
}

/**
 初始化栏目数据
 */
-(void)initArr{
    
    //    if ([self.pageModel.columnNavType isEqualToString:@"3"]) {
    //        for (int i=0 ; i<[self.pageModel.columnList count]; i++) {
    //            PDMITagItem *item=[self.pageModel.columnList objectAtIndex:i];
    //            item.width=ScreenWidth/2;
    //        }
    //    }
    self.statusBarStyle = UIStatusBarStyleLightContent;
    self.selectColumnArr=[[NSMutableArray alloc] init];
    //获取订阅的栏目
    NSArray *orderData=[[CommData shareInstance] getOrderedColumnDataWithTabId:self.pageModel.tabId];
    //如果栏目个数大于7，就显示7个
    if ([self.pageModel.columnList count]>column_NoAddBtn_num){
        
        if (orderData!=nil&&[orderData count]!=0) {
            for (int i=0; i<[orderData count]; i++) {
                PDMITagItem *item=[orderData objectAtIndex:i];
                NSInteger index = [self enumerateObjectWithArray:self.pageModel.columnList withObjectId:item.columnId];
                if (index!=-1) {
                    [self.selectColumnArr addObject:self.pageModel.columnList[index]];
                }
            }
            [[CommData shareInstance] saveOrderedColumnData:self.selectColumnArr withTabId:self.pageModel.tabId];
        }else{
            self.selectColumnArr= [[NSMutableArray alloc] initWithArray:[self.pageModel.columnList subarrayWithRange:NSMakeRange(0, column_NoAddBtn_num)]];
        }
    }else{
        self.selectColumnArr=self.pageModel.columnList;
    }
    
    
    
    //    if (orderData!=nil&&[orderData count]!=0) {
    //        //self.selectColumnArr=(NSMutableArray *)orderData;
    //
    //        for (int i=0; i<[orderData count]; i++) {
    //            PDMITagItem *item=[orderData objectAtIndex:i];
    //            if ([self enumerateObjectWithArray:self.pageModel.columnList withObjectId:item.columnId]!=-1) {
    //                [self.selectColumnArr addObject:item];
    //            }
    //
    //        }
    //        [[CommData shareInstance] saveOrderedColumnData:self.selectColumnArr withTabId:self.pageModel.tabId];
    //    }else{
    //        //if ([self.pageModel.columnNavType isEqualToString:@"1"]) { //有栏目导航，且可以动态添加
    //        if ([self.pageModel.columnList count]>column_NoAddBtn_num){
    //            //self.selectColumnArr= self.pageModel.columnList.count>4 ?[[NSMutableArray alloc] initWithArray:[self.pageModel.columnList subarrayWithRange:NSMakeRange(0, 4)]] :self.pageModel.columnList;
    //            self.selectColumnArr= [[NSMutableArray alloc] initWithArray:[self.pageModel.columnList subarrayWithRange:NSMakeRange(0, column_NoAddBtn_num)]];
    //
    //        }else{
    //            self.selectColumnArr=self.pageModel.columnList;
    //        }
    //
    //    }
    //
    //
    
    //if ([self.pageModel.columnNavType isEqualToString:@"1"]) { //有栏目导航，且可以动态添加
    if ([self.pageModel.columnList count]>column_NoAddBtn_num){
        self.unSelectColumnArr=[[NSMutableArray alloc] init];
        for (int i=0; i<[self.pageModel.columnList count]; i++) {
            // NSDictionary *dic=[arr objectAtIndex:i];
            
            PDMITagItem *item=[self.pageModel.columnList objectAtIndex:i];
            if ([self enumerateObjectWithArray:self.selectColumnArr withObjectId:item.columnId]==-1) {
                [self.unSelectColumnArr addObject:item];
            }
        }
    }
}

/**
 遍历数组找到已订阅的栏目的index

 @param arr 栏目数组
 @param subId 已订阅的栏目id
 @return 已订阅的栏目的index
 */
-(NSInteger)enumerateObjectWithArray:(NSArray *)arr withObjectId:(id)subId
{
    __block NSInteger index=-1;
    [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PDMITagItem *item=obj;
        if ([item.columnId isEqual:subId]) {
            index=idx;
        }
    }];
    return index;
}

# pragma mark - 初始化 栏目导航
-(void)initColumnView{
    
    self.slideView=[[DLCustomSlideView alloc] initWithFrame:CGRectMake(0,self.originY, self.view.frame.size.width, _originalHeight-self.originY)];
    if (self.navBarHidden==YES) {
        self.slideView.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20);
    }
    
    self.slideView.delegate=self;
    [self.view addSubview:self.slideView];
    
    
    
    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:10];
    DLScrollTabbarView *tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width, colummViewHeight)];
    
    //    if ([self.pageModel.columnNavType isEqualToString:@"1"]) {
    //        tabbar.showAddBtn=YES;
    //    }
    if ([self.pageModel.columnList count]>column_NoAddBtn_num) {
        tabbar.showAddBtn=YES;
    }
    
    tabbar.tabItemNormalColor = [CommData shareInstance].configModel.columnTitleColor;
    tabbar.tabItemSelectedColor = [CommData shareInstance].configModel.columnTitleSelectColor;
    if ([self.pageModel.pageStyle isEqualToString:@"-2"]) {
        tabbar.tabItemNormalFontSize = [CommData shareInstance].scale*(SecondTitleFontSize-2);
        tabbar.tabItemSelectedFontSize=[CommData shareInstance].scale*(FirstTitleFontSize-2);
    }else{
        tabbar.tabItemNormalFontSize = [CommData shareInstance].scale*SecondTitleFontSize;
        tabbar.tabItemSelectedFontSize=[CommData shareInstance].scale*SecondTitleFontSize;
    }
    
    tabbar.trackColor = UIColorFromRGB(0xF85759);//[CommData shareInstance].configModel.columnTitleSelectColor;
    
    tabbar.tabbarItems=[self.selectColumnArr copy];
    
    self.slideView.tabbar = tabbar;
    self.slideView.cache = cache;
    self.slideView.tabbarBottomSpacing = 0;
    self.slideView.baseViewController = self;
    [self.slideView setup];
    self.slideView.selectedIndex = 0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 获取控制器个数代理
 
 @param sender 控制器框架
 @return 控制器个数
 */
- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender{
    //return itemArray_.count;
    return [self.selectColumnArr count];
}
/**
 选择某个栏目是初始化选择栏目的控制器
 
 @param sender 控制器框架
 @param index 选中的栏目
 @return 生成的控制器
 */
- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index{
    
    PDMITagItem *item=[self.selectColumnArr objectAtIndex:index];
    XANewsListViewController *ctrl = [[XANewsListViewController alloc] init];
    ctrl.contentViewFrame=CGRectMake(0, 0, self.slideView.frame.size.width, self.slideView.frame.size.height-self.tabHeight-colummViewHeight);
    //    ctrl.view.backgroundColor = [UIColor redColor];
    ctrl.title=item.columnTitle;
    ctrl.columItem=item;
    return ctrl;
    
}
/**
 添加更多栏目按钮
 
 */
- (void)showOrHiddenAddChannelsCollectionView:(UIButton *)button{
    //    if (button.selected==YES) {
    // 初始化
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    _tagView = [[PDMITagView alloc] initWithSelectedItems:self.selectColumnArr  unselectedItems:self.unSelectColumnArr];
    // 设置代理 可以处理点击
    _tagView.delegate = self;
    _tagView.frame = [UIScreen mainScreen].bounds;
    //        _tagView.frame = CGRectMake(0, (CGRectGetMaxY(self.slideView.tabbar.frame)+self.slideView.frame.origin.y), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(CGRectGetMaxY(self.slideView.tabbar.frame)+self.slideView.frame.origin.y));
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 设置frame
    [window addSubview:_tagView];
    //    }else{
    
    //    }
}
//点击取消按钮
- (void)tagViewDidClickDeleteButton
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    DLScrollTabbarView *tabbar=( DLScrollTabbarView*)self.slideView.tabbar;
    
    
    if (![self.selectColumnArr isEqual:tabbar.tabbarItems] ) {
        
        PDMITagItem *selectItem=[tabbar.tabbarItems objectAtIndex:tabbar.selectedIndex ];
        
        tabbar.tabbarItems=[self.selectColumnArr copy];
        
        __block NSInteger index=0;
        [self.selectColumnArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PDMITagItem *item=obj;
            if ([item isEqual:selectItem]) {
                index=idx;
            }
        }];
        self.slideView.selectedIndex=index;
        [[CommData shareInstance] saveOrderedColumnData:self.selectColumnArr withTabId:self.pageModel.tabId];
    }
    [_tagView removeFromSuperview];
}
- (void)tagView:(PDMITagView *)tagView didSelectTagWhenNotInEditState:(NSInteger)index{
    DLScrollTabbarView *tabbar=( DLScrollTabbarView*)self.slideView.tabbar;
    
    
    if (![self.selectColumnArr isEqual:tabbar.tabbarItems] ) {
        
        tabbar.tabbarItems=[self.selectColumnArr copy];
    }
    self.slideView.selectedIndex=index;
    [tabbar clickAddButton:tabbar.addChannelButton];
}
/**
 点击编辑按钮
 */
-(void)editBtnPressed
{
    _tagView.inEditState=YES;
}
/**
 编辑结束
 */
-(void)editCompletedPressed
{
    self.selectColumnArr=_tagView.selectedItems;
    self.unSelectColumnArr=_tagView.unselectedItems;
    _tagView.inEditState=NO;
}
- (BOOL)shouldAutorotate
{
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}
@end
