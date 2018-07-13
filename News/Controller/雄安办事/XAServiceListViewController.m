//
//  XAServiceListViewController.m
//  News
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAServiceListViewController.h"
#import "XAAffairsTableView.h"

@interface XAServiceListViewController ()
@property(nonatomic,strong)XAAffairsTableView *newsView;
@property(nonatomic,assign)BOOL isMore;
@property(nonatomic,strong)NSString *nextPage;

@end

@implementation XAServiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitlelabel.text = self.titleName;
    if (CGRectIsNull(self.contentViewFrame)||CGRectEqualToRect(self.contentViewFrame, CGRectZero)) {
        self.newsView=[[XAAffairsTableView alloc] initWithFrame:CGRectMake(0,self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
    }else{
        self.newsView=[[XAAffairsTableView alloc] initWithFrame:self.contentViewFrame];
    }
    [self.view addSubview:self.newsView];
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
    [[NewsNetWork shareInstance] getMainListWithLink:self.urlStr WithComplete:^(id result) {
        [self.loadingView hide];
        [weakSelf resetNewsModelWithDict:result];
    } withErrorBlock:^(NSError *error) {
        [weakSelf setErrorViewWithCode:error.code];
        [weakSelf.loadingView hide];
    }];
}

/**
 处理网络下载数据

 */
- (void)resetNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    self.nextPage = result[@"nextPage"];
    
    NSArray *newsArray = result[@"articalList"];
    if (newsArray.count==0) {
        [self setErrorViewWithCode:-10];//如果没事数据显示页面正在建设中
    }
    NSArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [newsModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XANewsModel *newsModel = obj;
 //动态计算高度
            [newsModel caculateFrame];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsView.newsModelDataArray =newsModelArr;
            [self.newsView reloaData];
        });
    });
}
//加载更多
- (void)resetMoreNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    self.nextPage = result[@"nextPage"];

    NSArray *newsArray = result[@"articalList"];
    NSArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [newsModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XANewsModel *newsModel = obj;
            //动态计算高度
            [newsModel caculateFrame];
        }];
        NSMutableArray *totalArray = [[NSMutableArray alloc]initWithArray:self.newsView.newsModelDataArray];
        [totalArray addObjectsFromArray:newsModelArr];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsView.newsModelDataArray =totalArray;
            [self.newsView reloaData];
        });
    });
}
-(void)loadMore
{
    if (!self.isMore) {
        //没有更多数据
        [self.newsView resetRefreshFooterViewWithMore:NO];
        return;
    }
        __weak __typeof(self)weakSelf = self;
        NSString *url = [NSString stringWithFormat:@"%@%@",self.urlStr,self.nextPage];
        [[NewsNetWork shareInstance] getMainListWithLink:url WithComplete:^(id result) {
            [self.loadingView hide];
            [weakSelf resetMoreNewsModelWithDict:result];
        } withErrorBlock:^(NSError *error) {
            [weakSelf setErrorViewWithCode:error.code];
            [weakSelf.loadingView hide];
        }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
