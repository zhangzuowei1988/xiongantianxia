//
//  MeAttentionAndFansCell.h
//  News
//
//  Created by pdmi on 2017/7/3.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeAttentionAndFansCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *attentionView;
@property (weak, nonatomic) IBOutlet UIView *fansView;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@end
