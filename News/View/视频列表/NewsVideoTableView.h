//
//  NewsVideoTableView.h
//  News
//
//  Created by pdmi on 2017/6/14.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsBaseTableView.h"
@interface NewsVideoTableView :BaseView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NewsBaseTableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *contentDic;
@property(nonatomic,strong)NSMutableArray *listArr;
-(void)viewWillDissmiss;
-(void)reloaData;
@end
