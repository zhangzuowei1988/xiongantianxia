//
//  XANewsTableView.m
//  News
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANewsTableView.h"
#import "XABigDataTableView.h"
#import "XALeftPicNewsCell.h"
#import "XANonePicNewsCell.h"
#import "XAThreePicNewsCell.h"
#import "XATopPicNewsCell.h"
#import "XACyclePicView.h"
#import "MAgent.h"
#import "H5NewsDetailController.h"
#import "NewsPicContentController.h"
#import "XASpecialTopicViewController.h"

@interface XANewsTableView ()<UITableViewDelegate,UITableViewDataSource,XACyclePicViewDelegate>
{
}
@property(nonatomic,strong)XACyclePicView *cyclePicView;
@end

@implementation XANewsTableView
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
    XANewsModel *newsModel = self.newsModelDataArray[indexPath.row];
    if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
        //左文右图
        XALeftPicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XALeftPicNewsCellID];
        cell.newsModel = self.newsModelDataArray[indexPath.row];
        return cell;
    } else if(newsModel.newsCellPicType==NewsCellPicTypeNone) {
        //无图
        XANonePicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XANonePicNewsCellID];
        cell.newsModel = self.newsModelDataArray[indexPath.row];
        return cell;
    } else if (newsModel.newsCellPicType==NewsCellPicTypeThree) {
        //三图
        XAThreePicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XAThreePicNewsCellID];
        cell.newsModel = self.newsModelDataArray[indexPath.row];
        return cell;
    }else if (newsModel.newsCellPicType==NewsCellPicTypeTop) {
        //上文下图
        XATopPicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:XATopPicNewsCellID];
        cell.newsModel = self.newsModelDataArray[indexPath.row];
        return cell;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XANewsModel *newsModel = self.newsModelDataArray[indexPath.row];
    return newsModel.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XANewsModel *newsModel = self.newsModelDataArray[indexPath.row];
    [self goDetailViewController:newsModel];
}
- (void)goDetailViewController:(XANewsModel*)newsModel
{
    UIViewController *parentVC = [self parentController];
    switch (newsModel.contentType) {
        case NewsTypeAtricle:
        {
            H5NewsDetailController *detialVC = [[H5NewsDetailController alloc]init];
            detialVC.articleStr = newsModel.url;
            detialVC.showShareBtn = YES;
            detialVC.newsModel = newsModel;
            [parentVC.navigationController pushViewController:detialVC animated:YES];
        }
            break;
        case NewsTypeTopic:
        {
            XASpecialTopicViewController *specialTopicVC = [[XASpecialTopicViewController alloc]init];
            specialTopicVC.newsModel = newsModel;
            [parentVC.navigationController pushViewController:specialTopicVC animated:YES];
        }
            break;
        case NewsTypePictures:
        {
            NewsPicContentController *picContentVC = [[NewsPicContentController alloc]init];
            picContentVC.newsModel = newsModel;
            [parentVC.navigationController pushViewController:picContentVC animated:YES];

        }
            break;
        default:
        {
            H5NewsDetailController *detialVC = [[H5NewsDetailController alloc]init];
            detialVC.articleStr = newsModel.url;
            detialVC.showShareBtn = YES;
            detialVC.newsModel = newsModel;
            [parentVC.navigationController pushViewController:detialVC animated:YES];

        }
            break;
    }
}
#pragma mark - XACyclePicViewDelegate
-(void)XACyclePicViewDidSelectAtIndex:(NSInteger)index
{
    XANewsModel *newsModel = self.cycleModelDataArray[index];
    [self goDetailViewController:newsModel];
}
- (void)setCycleModelDataArray:(NSArray *)cycleModelDataArray
{
    _cycleModelDataArray = cycleModelDataArray;
    if (_cycleModelDataArray) {
        self.cyclePicView.cycleDataArray = _cycleModelDataArray;
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
     //   [self.tableView.mj_footer endRefreshing];

    self.tableView.mj_footer.state=MJRefreshStateNoMoreData;
    }
}
@end
