//
//  XAPublishNewsViewController.m
//  News
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAPublishNewsViewController.h"
#import "XAPublishNewsTableView.h"

@interface XAPublishNewsViewController ()
@property(nonatomic,strong)XAPublishNewsTableView *newsView;
@property(nonatomic,strong)XAPublishNewsModel *dataModel;
@property(nonatomic,assign)BOOL isMore;
@property(nonatomic,strong)NSString *nextPage;

@end

@implementation XAPublishNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    if (CGRectIsNull(self.contentViewFrame)||CGRectEqualToRect(self.contentViewFrame, CGRectZero)) {
        self.newsView=[[XAPublishNewsTableView alloc] initWithFrame:CGRectMake(0,self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY-self.tabHeight)];
    }else{
        self.newsView=[[XAPublishNewsTableView alloc] initWithFrame:self.contentViewFrame];
    }
    [self.view addSubview:self.newsView];
    //添加loading框
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    //刷新
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
        [weakSelf resetNewsModelWithDict:result[@"data"]];
    } withErrorBlock:^(NSError *error) {
        if (self.newsView.newsModelDataArray==0) {
            [weakSelf setErrorViewWithCode:error.code];
        }
        [weakSelf.loadingView hide];
        [self.newsView reloaData];
    }];
}

/**
 处理网络下载的数据

 */
- (void)resetNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    if (!self.isMore) {
        [self.newsView resetRefreshFooterViewWithMore:NO];
    }
    self.nextPage = result[@"nextPage"];
 
    NSArray *newsArray = result[@"newsList"];
    NSMutableArray *newsModelArr =[XAPublishNewsModel mj_objectArrayWithKeyValuesArray:newsArray];
    
    NSMutableArray *carounseModelArr = [[NSMutableArray alloc]init];
    //获取列表的前三个做为轮播图
    int count = 0;
    for (XAPublishNewsModel *model in newsModelArr) {
        if (model.imageUrls.count>0) {
            [carounseModelArr addObject:model];
            count++;
        }
        if (count==3) {
            break;
        }
    }
    [newsModelArr removeObjectsInArray:carounseModelArr];
    self.newsView.cycleModelDataArray = carounseModelArr;

    NSArray *advertArray = result[@"advert"];
    NSArray *advertModelArray = [XAPublishNewsModel mj_objectArrayWithKeyValuesArray:advertArray];
    //插入广告
    for (XAPublishNewsModel *advertModel in advertModelArray) {
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
            XAPublishNewsModel *newsModel = obj;
            if (idx>0&&idx%4==0) {
                if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
                    newsModel.newsCellPicType=NewsCellPicTypeTop;
                }
            }
            [newsModel caculateFrame];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsView.newsModelDataArray =newsModelArr;
            [self.newsView reloaData];
        });
    });
}

/**
 加载更多
 */
-(void)loadMore
{
    if (!self.isMore) {
        //        [self.newsView reloaData];
        //        [self.newsView.tableView.mj_header endRefreshing];
        // [self.newsView.tableView.mj_footer endRefreshingWithCompletionBlock:^{
        // [self.newsView.tableView reloadData];
        // }];
        
        [self.newsView resetRefreshFooterViewWithMore:NO];
        
        return;
    }
    __weak __typeof(self)weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@%@",self.columItem.columnLink,self.nextPage];
    [[NewsNetWork shareInstance] getMainListWithLink:url WithComplete:^(id result) {
        [self.loadingView hide];
        [weakSelf resetMoreNewsModelWithDict:result[@"data"]];
        
        //            NSLog(@"more%@",result);
    } withErrorBlock:^(NSError *error) {
        //            [weakSelf setErrorViewWithCode:error.code];
        [weakSelf.loadingView hide];
        //    [self.newsView reloaData];
        [self.newsView.tableView.mj_footer endRefreshing];
    }];
}
//处理加载更多数据
- (void)resetMoreNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    if (!self.isMore) {
        [self.newsView resetRefreshFooterViewWithMore:NO];
    }
    self.nextPage = result[@"nextPage"];
    NSArray *newsArray = result[@"newsList"];
    NSMutableArray *newsModelArr =[XAPublishNewsModel mj_objectArrayWithKeyValuesArray:newsArray];
    NSArray *advertArray = result[@"advert"];
    NSArray *advertModelArray = [XAPublishNewsModel mj_objectArrayWithKeyValuesArray:advertArray];
    //插入广告
    for (XAPublishNewsModel *advertModel in advertModelArray) {
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
        NSMutableArray *totalArray = [[NSMutableArray alloc]initWithArray:self.newsView.newsModelDataArray];
        [totalArray addObjectsFromArray:newsModelArr];
        [totalArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XAPublishNewsModel *newsModel = obj;
            if (idx>0&&idx%4==0) {
                if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
                    newsModel.newsCellPicType=NewsCellPicTypeTop;
                }
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
