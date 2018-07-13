//
//  NewsBaseTableView.m
//  News
//
//  Created by pdmi on 2017/6/14.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "NewsBaseTableView.h"
#import "UIView+parentController.h"
#import "BaseViewController.h"

@implementation NewsBaseTableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
       
        [self setSeparatorInset:UIEdgeInsetsZero];
        
        self.separatorColor = setRGBColor(220,220,220, 1);

        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
     //   self.tableFooterView = [[UIView alloc] init];
//        self.tableHeaderView=[[UIView alloc]init];
       
        [self setRefreshView];
 }
    return self;
}

-(void)setRefreshView{
    
//    if ([[self parentController] isKindOfClass:[BaseViewController class]]) {
//        BaseViewController *controller=(BaseViewController*)[self parentController];
//       // [controller loadMore];
//        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:controller refreshingAction:@selector(loadMore)];
//        
//        // 设置文字
//        [footer setTitle:@"向上拖拽加载更多" forState:MJRefreshStateIdle];
//        [footer setTitle:@"正在加载更多数据" forState:MJRefreshStateRefreshing];
//        [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
//
//        self.mj_footer=footer;
//    }

    
   
   

    
    
     __weak NewsBaseTableView *tableView=self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([[tableView parentController] isKindOfClass:[BaseViewController class]]) {
            BaseViewController *controller=(BaseViewController*)[tableView parentController];
            [controller refresh];
        }
        
        
    }];
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([[tableView parentController] isKindOfClass:[BaseViewController class]]) {
            BaseViewController *controller=(BaseViewController*)[tableView parentController];
            [controller loadMore];
        }        }];
    
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self=[super initWithFrame:frame style:style]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
        
       
//        [self setLayoutMargins:UIEdgeInsetsZero];
      
//       self.tableFooterView = [[UIView alloc] init];
//        self.tableHeaderView=[[UIView alloc]init];
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
        [self setRefreshView];
     
        
    }
    return self;

}

-(void)execute{
    [self reloadData];
}
-(void)dealloc{
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:ChangedisplayStyle object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
