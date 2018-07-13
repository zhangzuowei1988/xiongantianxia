//
//  CommentHeaderView.h
//  News
//
//  Created by pdmi on 2017/5/19.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentHeaderView : UITableViewHeaderFooterView
+ (instancetype)topicHeaderView;
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
