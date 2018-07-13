//
//  ContentVideoView.h
//  News
//
//  Created by pdmi on 2017/6/8.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentVideoView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *contentDic;
@property(nonatomic,strong)NSMutableArray *structArr;
@end
