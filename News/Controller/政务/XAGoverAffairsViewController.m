//
//  XAGoverAffairsViewController.m
//  News
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAGoverAffairsViewController.h"
#import "XAGoverAffairsTableView.h"
#import "XAGoverAffairsModel.h"
#import "XANewsModel.h"

@interface XAGoverAffairsViewController ()
{
    XAGoverAffairsTableView *_goverAffairsTableView;
}
@property(nonatomic,assign)BOOL isMore;
@property(nonatomic,strong)NSString *nextPage;

@end

@implementation XAGoverAffairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    if (CGRectIsNull(self.contentViewFrame)||CGRectEqualToRect(self.contentViewFrame, CGRectZero)) {
        _goverAffairsTableView=[[XAGoverAffairsTableView alloc] initWithFrame:CGRectMake(0,self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY-self.tabHeight)];
    }else{
        _goverAffairsTableView=[[XAGoverAffairsTableView alloc] initWithFrame:self.contentViewFrame];
    }
    [self.view addSubview:_goverAffairsTableView];
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    topLineView.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [self.view addSubview:topLineView];
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}
#pragma mark - loadingView
-(void)setLoadingView
{
    if (!self.loadingView) {
        self.loadingView=[[JHUD alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        self.loadingView.messageLabel.text=LOADING_TITLE;
    }
}
#pragma mark - 重新加载
- (void)reLoadRequest
{
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}
#pragma mark - 刷新
-(void)refresh{

    if (self.errorView!=nil) {
        [self.errorView setHidden:YES];
    }
    __weak __typeof(self)weakSelf = self;
    [[NewsNetWork shareInstance] getMainListWithLink:self.columItem.columnLink WithComplete:^(id result) {
        [self.loadingView hide];
        [weakSelf resetNewsModelWithDict:result];
    } withErrorBlock:^(NSError *error) {
        if (_goverAffairsTableView.affairsDataArray.count==0) {
            [weakSelf setErrorViewWithCode:error.code];
        }
        [weakSelf.loadingView hide];
        [_goverAffairsTableView reloaData];

    }];
}

/**
 处理网络请求数据

 */
- (void)resetNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    self.nextPage = result[@"nextPage"];
    NSArray *newsArray = result[@"list"];
    NSMutableArray *modelsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<newsArray.count; i++) {
        NSDictionary *dict = newsArray[i];
        XAGoverAffairsModel *model = [[XAGoverAffairsModel alloc]init];
        model.affairsContent = checkNull(dict[@"title"]);
        model.affairsTime = checkNull(dict[@"publishDate"]);
        model.affairsSource = checkNull(dict[@"sourceName"]);
        model.affairsUrl = checkNull(dict[@"url"]);
//        model.affairsTitle = checkNull(result[@"columnName"]);
        model.affairsTitle = self.columItem.columnTitle;
        [model caculateFrame];
        [modelsArray addObject:model];
    }
    _goverAffairsTableView.affairsDataArray =modelsArray;
    [_goverAffairsTableView reloaData];
}
//加载更多
- (void)resetMoreNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    self.nextPage = result[@"nextPage"];
    NSArray *newsArray = result[@"list"];
    NSMutableArray *modelsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<newsArray.count; i++) {
        NSDictionary *dict = newsArray[i];
        XAGoverAffairsModel *model = [[XAGoverAffairsModel alloc]init];
        model.affairsContent = checkNull(dict[@"title"]);
        model.affairsTime = checkNull(dict[@"publishDate"]);
        model.affairsSource = checkNull(dict[@"sourceName"]);
        model.affairsUrl = checkNull(dict[@"url"]);
//        model.affairsTitle = checkNull(result[@"columnName"]);
        model.affairsTitle = self.columItem.columnTitle;
        [model caculateFrame];
        [modelsArray addObject:model];
    }
    
    NSMutableArray *totalArray = [[NSMutableArray alloc]initWithArray:_goverAffairsTableView.affairsDataArray];
    [totalArray addObjectsFromArray:modelsArray];
    _goverAffairsTableView.affairsDataArray =totalArray;
    [_goverAffairsTableView reloaData];
}

/**
 网络加载更多
 */
-(void)loadMore
{
    if (self.isMore) {
        __weak __typeof(self)weakSelf = self;
        NSString *url = [NSString stringWithFormat:@"%@%@",self.columItem.columnLink,self.nextPage];
        [[NewsNetWork shareInstance] getMainListWithLink:url WithComplete:^(id result) {
            [self.loadingView hide];
            [weakSelf resetMoreNewsModelWithDict:result];
        } withErrorBlock:^(NSError *error) {
//            [weakSelf setErrorViewWithCode:error.code];
            [weakSelf.loadingView hide];
            [_goverAffairsTableView reloaData];

        }];
    } else {
        [_goverAffairsTableView resetRefreshFooterViewWithMore:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
