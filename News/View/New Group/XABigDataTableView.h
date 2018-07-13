//
//  XABigDataTableView.h
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsBaseTableView.h"
@interface XABigDataTableView : BaseView

@property(nonatomic,strong)NewsBaseTableView *tableView;
@property(nonatomic,strong)NSArray *bigDataNewsDataArray;
/**
 刷新cell
 */

-(void)reloaData;
/**
 重置上拉加载更多
 
 @param more 是否有更多数据
 */

-(void)resetRefreshFooterViewWithMore:(BOOL)more;

@end
