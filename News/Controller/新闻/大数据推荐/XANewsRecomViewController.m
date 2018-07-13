//
//  XARecomViewController.m
//  News
//
//  Created by mac on 2018/4/28.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANewsRecomViewController.h"
#import "XABigDataTableView.h"
#import "NewsAgent.h"
#import "XABigDataNewsModel.h"
@interface XANewsRecomViewController()
{
    XABigDataTableView *_bigDataTableView;
    BOOL isFirst;
}
@end

@implementation XANewsRecomViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navBarHidden = YES;
    isFirst = YES;
    if (CGRectIsNull(self.contentViewFrame)||CGRectEqualToRect(self.contentViewFrame, CGRectZero)) {
        _bigDataTableView=[[XABigDataTableView alloc] initWithFrame:CGRectMake(0,self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY-self.tabHeight)];
    }else{
        _bigDataTableView=[[XABigDataTableView alloc] initWithFrame:self.contentViewFrame];
    }
    [self.view addSubview:_bigDataTableView];
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    topLineView.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [self.view addSubview:topLineView];
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}

-(void)reLoadRequest
{
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

/**
 下拉刷新
 */
- (void)refresh
{
//    [[XABigDataNewsNetWork shareInstance] requestWithSpotTagName:self.columItem.adspot completion:^(id responseObject, NSError *error) {
//
//    }];
    if (self.errorView!=nil) {
        [self.errorView setHidden:YES];
    }
    //1.    大数据加载逻辑，第一次加载时参数max_behot_time传-1，下拉刷新时传0
    //如果下拉刷新的数据小于10条就丢弃，大于10条刷新列表

    [[NewsNetWork shareInstance] getBigDataListWithTagName:self.columItem.adspot isFirst:isFirst  WithComplete:^(id result) {
        [self.loadingView hide];
        NSArray *dataArray = result[@"result_list"];
        
       NSArray *modelArray = [XABigDataNewsModel mj_objectArrayWithKeyValuesArray:dataArray];
        //modelArray = [self handleArrayWithModelArray:modelArray];
        if (modelArray.count<10&&!isFirst) {
            [_bigDataTableView reloaData];
            return ;
        }
        for (int i =0 ;i<modelArray.count;i++) {
            XABigDataNewsModel *model = modelArray[i];
            [model caculateFrame];
        }

        _bigDataTableView.bigDataNewsDataArray = modelArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_bigDataTableView reloaData];
        });
        isFirst = NO;
    } withErrorBlock:^(NSError *error) {
        if(_bigDataTableView.bigDataNewsDataArray.count==0){
            [self setErrorViewWithCode:error.code];
        }
        [self.loadingView hide];
        [_bigDataTableView reloaData];
    }];
}

/**
 上拉加载更多
 */
-(void)loadMore
{
    //大数据加载更多，max_behot_time传上次请求的最后一条新闻的推荐时间
    XABigDataNewsModel *lastModel =_bigDataTableView.bigDataNewsDataArray.lastObject;
    [[NewsNetWork shareInstance] getBigDataListWithTagName:self.columItem.adspot recTime:@([lastModel.rec_time integerValue]) WithComplete:^(id result) {
        NSArray *dataArray = result[@"result_list"];
        if (dataArray.count == 0) {
            [_bigDataTableView reloaData];
            return ;
        }
        NSArray *modelArray = [XABigDataNewsModel mj_objectArrayWithKeyValuesArray:dataArray];
       // modelArray = [self handleArrayWithModelArray:modelArray];
        NSMutableArray *newArray = [NSMutableArray arrayWithArray:_bigDataTableView.bigDataNewsDataArray];
        [newArray addObjectsFromArray:modelArray];
        for (int i =0 ;i<newArray.count;i++) {
            XABigDataNewsModel *model = newArray[i];
            [model caculateFrame];
        }
        _bigDataTableView.bigDataNewsDataArray = newArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_bigDataTableView reloaData];

//            NSInteger baseCount = newArray.count - [modelArray count];
//            NSMutableArray *arr = [NSMutableArray array];
//            for (int i = 0; i < [modelArray count]; i++) {
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:baseCount + i inSection:0];
//                [arr addObject:indexPath];
//            }
//            [_bigDataTableView.tableView.mj_footer endRefreshing];
//
////            [_bigDataTableView.tableView beginUpdates];
//            [_bigDataTableView.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
////            [_bigDataTableView.tableView endUpdates];
           // [_bigDataTableView.tableView.mj_footer endRefreshing];
           // [_bigDataTableView.tableView reloadData];
            
        });
    } withErrorBlock:^(NSError *error) {
        [_bigDataTableView reloaData];
        [self.loadingView hide];
//        [self setErrorViewWithCode:error.code];

    }];

}

@end
