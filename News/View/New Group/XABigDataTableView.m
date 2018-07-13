//
//  XABigDataTableView.m
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XABigDataTableView.h"
#import "NewsBaseTableView.h"
#import "XALeftPicNewsCell.h"
#import "XANonePicNewsCell.h"
#import "XAThreePicNewsCell.h"
#import "XATopPicNewsCell.h"
#import "H5NewsDetailController.h"
#import "MAgent.h"
@interface XABigDataTableView ()<UITableViewDelegate,UITableViewDataSource>
{
}
@end

@implementation XABigDataTableView
static NSString *XALeftPicNewsCellID = @"XALeftPicNewsCell";
static NSString *XANonePicNewsCellID = @"XANonePicNewsCell";
static NSString *XAThreePicNewsCellID = @"XAThreePicNewsCell";
static NSString *XATopPicNewsCellID = @"XATopPicNewsCell";

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTableView];
    }
    return self;
}
- (void)addTableView
{
    _tableView = [[NewsBaseTableView alloc]initWithFrame:self.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerClass:[XALeftPicNewsCell class] forCellReuseIdentifier:XALeftPicNewsCellID];
    [_tableView registerClass:[XANonePicNewsCell class] forCellReuseIdentifier:XANonePicNewsCellID];
    [_tableView registerClass:[XAThreePicNewsCell class] forCellReuseIdentifier:XAThreePicNewsCellID];
    [_tableView registerClass:[XATopPicNewsCell class] forCellReuseIdentifier:XATopPicNewsCellID];
    [self addSubview:_tableView];
//    if (@available(iOS 11.0, *)) {
//        _tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
//        _tableView.contentInset =UIEdgeInsetsMake(64,0,49,0);//64和49自己看效果，是否应该改成0
//        _tableView.scrollIndicatorInsets =_tableView.contentInset;
//    }
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bigDataNewsDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XABigDataNewsModel *newsModel = self.bigDataNewsDataArray[indexPath.row];
    if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
        //左图右文
        XALeftPicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XALeftPicNewsCellID];
        cell.bigDataNewsModel = self.bigDataNewsDataArray[indexPath.row];
        return cell;
    } else if(newsModel.newsCellPicType==NewsCellPicTypeNone) {
        //无图
        XANonePicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XANonePicNewsCellID];
        cell.bigDataNewsModel = self.bigDataNewsDataArray[indexPath.row];
        return cell;
    } else if (newsModel.newsCellPicType==NewsCellPicTypeThree) {
        //三图
        XAThreePicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XAThreePicNewsCellID];
        cell.bigDataNewsModel = self.bigDataNewsDataArray[indexPath.row];
        return cell;
    }else if (newsModel.newsCellPicType==NewsCellPicTypeTop) {
        //上图下文
        XATopPicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XATopPicNewsCellID];
        cell.bigDataNewsModel = self.bigDataNewsDataArray[indexPath.row];
        return cell;
    }

    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XABigDataNewsModel *newsModel = self.bigDataNewsDataArray[indexPath.row];
    return newsModel.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XABigDataNewsModel *newsModel = self.bigDataNewsDataArray[indexPath.row];
    H5NewsDetailController *contentViewController = [[H5NewsDetailController alloc]init];
    contentViewController.showShareBtn = YES;
    contentViewController.bigDataNewsModel = newsModel;
    contentViewController.articleStr = newsModel.clickUrl;
    UIViewController *viewController = [self parentController];
    [viewController.navigationController pushViewController:contentViewController animated:YES];
}
- (void)reloaData
{
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];

}

-(void)resetRefreshFooterViewWithMore:(BOOL)more
{
    if (more==NO) {
       // [self.tableView.mj_footer endRefreshing];
        
        self.tableView.mj_footer.state=MJRefreshStateNoMoreData;
        
    }
}
@end
