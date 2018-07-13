//
//  XAGoverAffairsViewController.m
//  News
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAGoverAffairsMainViewController.h"
#import "DLCustomSlideView.h"
#import "PDMITagView.h"
#import "XAGoverAffairsListViewController.h"
#import "DLLRUCache.h"
#import "DLScrollTabbarView.h"
#define colummViewHeight 37//选择栏的高度

@interface XAGoverAffairsMainViewController ()<DLCustomSlideViewDelegate,PDMITagViewDelegate>
{
    
}
@property(nonatomic,strong)NSMutableArray *selectColumnArr;//已订阅的栏目
@property(nonatomic,strong)NSMutableArray *unSelectColumnArr;//未订阅的栏目
@property(nonatomic,strong)DLCustomSlideView *slideView;//滑动框架
@property (strong, nonatomic) PDMITagView *tagView;
@end

@implementation XAGoverAffairsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitlelabel.text = @"雄安 • 政务";
    [self initColumArray];
    [self initColumnView];
}

/**
 初始化栏目个数
 */
-(void)initColumArray{
    //栏目个数暂时写在前端、以后后台可扩展
    
    NSString *jsonStr=[[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"configure/config-government-colume" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *columDic=[jsonStr JSONObject];
    NSArray *columArray = columDic[@"data"][@"colum"];
    self.selectColumnArr=[[NSMutableArray alloc] init];
    for (int i =0; i<columArray.count; i++) {
        PDMITagItem *tagItem = [[PDMITagItem alloc]initWithDict:columArray[i]];
        tagItem.width = ScreenWidth/columArray.count;
        [self.selectColumnArr addObject:tagItem];
    }
}
-(NSInteger)enumerateObjectWithArray:(NSArray *)arr withObjectId:(id)subId
{
    __block NSInteger index=-1;
    [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PDMITagItem *item=obj;
        if ([item.columnId isEqual:subId]) {
            //NSLog(@"%@-索引%d",obj, (int)idx);
            index=idx;
        }
    }];
    return index;
}
# pragma mark - 初始化 栏目导航
-(void)initColumnView{
    
    self.slideView=[[DLCustomSlideView alloc] initWithFrame:CGRectMake(0,self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
    if (self.navBarHidden==YES) {
        self.slideView.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20);
    }
    
    self.slideView.delegate=self;
    [self.view addSubview:self.slideView];
    
    
    
    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:10];
    DLScrollTabbarView *tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, colummViewHeight)];
    
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
    
    XAGoverAffairsListViewController *ctrl = [[XAGoverAffairsListViewController alloc] init];
    ctrl.contentViewFrame=CGRectMake(0, 0, self.slideView.frame.size.width, self.slideView.frame.size.height-self.tabHeight-colummViewHeight);
    
    ctrl.title=item.columnTitle;
    ctrl.columItem=item;
    return ctrl;
    
    
}

/**
 添加更多栏目按钮

 */
- (void)showOrHiddenAddChannelsCollectionView:(UIButton *)button{
    if (button.selected==YES) {
        // 初始化
        _tagView = [[PDMITagView alloc] initWithSelectedItems:self.selectColumnArr  unselectedItems:self.unSelectColumnArr];
        
        // 设置代理 可以处理点击
        _tagView.delegate = self;
        _tagView.frame = CGRectMake(0, (CGRectGetMaxY(self.slideView.tabbar.frame)+self.slideView.frame.origin.y), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(CGRectGetMaxY(self.slideView.tabbar.frame)+self.slideView.frame.origin.y));
        
        // 设置frame
        [self.view addSubview:_tagView];
    }else{
        
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
            
            NSLog(@"%d",[[CommData shareInstance] saveOrderedColumnData:self.selectColumnArr withTabId:self.pageModel.tabId]);
            
        }
        
        [_tagView removeFromSuperview];
        
    }
    
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
@end
