//
//  XANewsTableView.h
//  News
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XANewsModel.h"
#import "NewsBaseTableView.h"

@interface XANewsTableView : BaseView
@property(nonatomic,strong)NSArray *newsModelDataArray;
@property(nonatomic,strong)NSArray *cycleModelDataArray;
@property(nonatomic,strong)NewsBaseTableView *tableView;
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
