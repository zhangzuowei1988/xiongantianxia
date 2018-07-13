//
//  XAPublishNewsTableView.m
//  News
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAPublishNewsTableView.h"

#import "XANewsTableView.h"
#import "XABigDataTableView.h"
#import "XALeftPicNewsCell.h"
#import "XANonePicNewsCell.h"
#import "XAThreePicNewsCell.h"
#import "XATopPicNewsCell.h"
#import "XACyclePicView.h"
#import "H5NewsDetailController.h"
#import "NewsPicContentController.h"
#import "XASpecialTopicViewController.h"
#import "XAPublishNewsContentViewController.h"

@interface XAPublishNewsTableView ()<UITableViewDelegate,UITableViewDataSource,XACyclePicViewDelegate>
{
}
@property(nonatomic,strong)XACyclePicView *cyclePicView;
@end

@implementation XAPublishNewsTableView
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
}
-(XACyclePicView *)cyclePicView
{
    if (!_cyclePicView) {
        _cyclePicView = [[XACyclePicView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*203/375)];
        _cyclePicView.delegate = self;
    }
    return _cyclePicView;
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsModelDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XAPublishNewsModel *newsModel = self.newsModelDataArray[indexPath.row];
    if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
        XALeftPicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XALeftPicNewsCellID];
        cell.publishNewsModel = self.newsModelDataArray[indexPath.row];
        return cell;
    } else if(newsModel.newsCellPicType==NewsCellPicTypeNone) {
        XANonePicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XANonePicNewsCellID];
        cell.publishNewsModel = self.newsModelDataArray[indexPath.row];
        return cell;
    } else if (newsModel.newsCellPicType==NewsCellPicTypeTop) {
        XATopPicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XATopPicNewsCellID];
        cell.publishNewsModel = self.newsModelDataArray[indexPath.row];
        return cell;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XAPublishNewsModel *newsModel = self.newsModelDataArray[indexPath.row];
    return newsModel.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XAPublishNewsModel *newsModel = self.newsModelDataArray[indexPath.row];
    [self goDetailViewController:newsModel];
}
- (void)goDetailViewController:(XAPublishNewsModel*)newsModel
{
    UIViewController *parentVC = [self parentController];
    XAPublishNewsContentViewController *publishNewsVC = [[XAPublishNewsContentViewController alloc]init];
    publishNewsVC.uri = newsModel.articleLink;
    [parentVC.navigationController pushViewController:publishNewsVC animated:YES];
}
#pragma mark - XACyclePicViewDelegate
-(void)XACyclePicViewDidSelectAtIndex:(NSInteger)index
{
    XAPublishNewsModel *newsModel = self.cycleModelDataArray[index];
    [self goDetailViewController:newsModel];
}
- (void)setCycleModelDataArray:(NSArray *)cycleModelDataArray
{
    _cycleModelDataArray = cycleModelDataArray;
    if (_cycleModelDataArray) {
        self.cyclePicView.xaPublishCycleDataArray = _cycleModelDataArray;
        _tableView.tableHeaderView = self.cyclePicView;
    }
}
- (void)reloaData
{
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [_tableView reloadData];
}

-(void)resetRefreshFooterViewWithMore:(BOOL)more
{
    if (more==NO) {
       // [self.tableView.mj_footer endRefreshing];
        
        self.tableView.mj_footer.state=MJRefreshStateNoMoreData;
        
    }
}
@end
