//
//  XARecommendViewController.m
//  News
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XARecommendViewController.h"
#import "XANewsTableView.h"

@interface XARecommendViewController ()
@property(nonatomic,strong)XANewsTableView *newsView;
@property(nonatomic,assign)BOOL isMore;
@property(nonatomic,strong)NSString *nextPage;

@end

@implementation XARecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    if (CGRectIsNull(self.contentViewFrame)||CGRectEqualToRect(self.contentViewFrame, CGRectZero)) {
        self.newsView=[[XANewsTableView alloc] initWithFrame:CGRectMake(0,self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY-self.tabHeight)];
    }else{
        self.newsView=[[XANewsTableView alloc] initWithFrame:self.contentViewFrame];
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
    [[NewsNetWork shareInstance] getMainListWithLink:self.columItem.columnLink WithComplete:^(id result) {
        [self.loadingView hide];
        [weakSelf resetNewsModelWithDict:result];
    } withErrorBlock:^(NSError *error) {
        if (self.newsView.newsModelDataArray==0) {
            [weakSelf setErrorViewWithCode:error.code];
        }
        [weakSelf.loadingView hide];
        [self.newsView reloaData];
    }];
}

/**
 处理网络下载数据

 */
- (void)resetNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    if (!self.isMore) {
        [self.newsView resetRefreshFooterViewWithMore:NO];
    }
    self.nextPage = result[@"nextPage"];
    NSArray *carouselArray = result[@"carousel"];
    if (carouselArray.count>0) {//轮播图
        NSArray *carounseModelArr = [XANewsModel mj_objectArrayWithKeyValuesArray:carouselArray];
        self.newsView.cycleModelDataArray = carounseModelArr;
    }
    NSArray *newsArray = result[@"list"];
    NSMutableArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
    NSArray *advertArray = result[@"advert"];
    NSArray *advertModelArray = [XANewsModel mj_objectArrayWithKeyValuesArray:advertArray];
    //根据广告位置插入广告
    for (XANewsModel *advertModel in advertModelArray) {
        if(advertModel.title){
            if (advertModel.numbersIndex<newsModelArr.count) {
                [newsModelArr insertObject:advertModel atIndex:advertModel.numbersIndex];
            }else {
                [newsModelArr addObject:advertModel];
            }
        }
    }
    //新闻列表页的cell有4种，左图右文、上图下文、三图、无图。每隔四个cell放一个上图下文的，如果第五个cell是三图的就跳过，如果是左图右文的就改成上图下文的
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [newsModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XANewsModel *newsModel = obj;
            if (idx>0&&idx%4==0) {
                if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
                    newsModel.newsCellPicType=NewsCellPicTypeTop;
                }
            }
            if (newsModel.contentType==NewsTypeTopic) {
                newsModel.newsCellPicType=NewsCellPicTypeTop;
            }
            [newsModel caculateFrame];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsView.newsModelDataArray =newsModelArr;
            [self.newsView reloaData];
        });
    });
}
-(void)loadMore
{
    if (!self.isMore) {

        [self.newsView resetRefreshFooterViewWithMore:NO];

        return;
    }
        __weak __typeof(self)weakSelf = self;
        NSString *url = [NSString stringWithFormat:@"%@%@",self.columItem.columnLink,self.nextPage];
        [[NewsNetWork shareInstance] getMainListWithLink:url WithComplete:^(id result) {
            [self.loadingView hide];
            [weakSelf resetMoreNewsModelWithDict:result];
 
        } withErrorBlock:^(NSError *error) {
            [weakSelf.loadingView hide];
            [self.newsView.tableView.mj_footer endRefreshing];
        }];
}
//加载更多
- (void)resetMoreNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    if (!self.isMore) {
        [self.newsView resetRefreshFooterViewWithMore:NO];
    }
    self.nextPage = result[@"nextPage"];
    NSArray *carouselArray = result[@"carousel"];
    if (carouselArray.count>0) {//轮播图
        NSArray *carounseModelArr = [XANewsModel mj_objectArrayWithKeyValuesArray:carouselArray];
        self.newsView.cycleModelDataArray = carounseModelArr;
    }
    
    NSArray *newsArray = result[@"list"];
    NSMutableArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
    NSArray *advertArray = result[@"advert"];
    NSArray *advertModelArray = [XANewsModel mj_objectArrayWithKeyValuesArray:advertArray];
    //根据广告位置插入广告
    for (XANewsModel *advertModel in advertModelArray) {
        if(advertModel.title){
            if (advertModel.numbersIndex<newsModelArr.count) {
                [newsModelArr insertObject:advertModel atIndex:advertModel.numbersIndex];
            }else {
                [newsModelArr addObject:advertModel];
            }
        }
    }    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *totalArray = [[NSMutableArray alloc]initWithArray:self.newsView.newsModelDataArray];
        [totalArray addObjectsFromArray:newsModelArr];
        //新闻列表页的cell有4种，左图右文、上图下文、三图、无图。每隔四个cell放一个上图下文的，如果第五个cell是三图的就跳过，如果是左图右文的就改成上图下文的
        [totalArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XANewsModel *newsModel = obj;
            if (idx>0&&idx%4==0) {
                if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
                    newsModel.newsCellPicType=NewsCellPicTypeTop;
                }
            }
            if (newsModel.contentType==NewsTypeTopic) {
                newsModel.newsCellPicType=NewsCellPicTypeTop;
            }
            [newsModel caculateFrame];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsView.newsModelDataArray =totalArray;
            [self.newsView reloaData];
        });
    });
}


@end
