//
//  XASearchHistoryView.m
//  News
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XASearchHistoryView.h"

@interface XASearchHistoryView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation XASearchHistoryView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    return self;
}
-(void)addContentView
{
    _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}
@end
