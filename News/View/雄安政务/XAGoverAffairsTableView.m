//
//  XAGoverAffairsTableView.m
//  News
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAGoverAffairsTableView.h"
#import "NewsBaseTableView.h"
#import "H5NewsDetailController.h"
#import "H5XADetailViewController.h"
@interface XAGoverAffairsTableView()<UITableViewDelegate,UITableViewDataSource>
{
    NewsBaseTableView *_tableView;
}
@end

@implementation XAGoverAffairsTableView

static NSString *cellId = @"XAGoverAffairsCell";

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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerClass:[XAGoverAffairsCell class] forCellReuseIdentifier:cellId];
    [self addSubview:_tableView];
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.affairsDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XAGoverAffairsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.goverAffairsModel = self.affairsDataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XAGoverAffairsModel *model =self.affairsDataArray[indexPath.row];
    return model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XAGoverAffairsModel *model = self.affairsDataArray[indexPath.row];
    H5XADetailViewController *detailController = [[H5XADetailViewController alloc]init];
    detailController.url = model.affairsUrl;
    detailController.myTitle = model.affairsTitle;
    detailController.shareTitle = model.affairsContent;
    [[self parentController].navigationController pushViewController:detailController animated:YES];
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
       // [_tableView.mj_footer endRefreshing];

        _tableView.mj_footer.state=MJRefreshStateNoMoreData;
        
    }
}

@end
