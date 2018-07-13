//
//  XAGoverAffairsTableView.h
//  News
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "BaseView.h"
#import "XAGoverAffairsCell.h"

@interface XAGoverAffairsTableView : BaseView
@property(nonatomic,strong)NSArray *affairsDataArray;

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
