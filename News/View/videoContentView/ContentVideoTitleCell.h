//
//  ContentVideoTitleCell.h
//  News
//
//  Created by pdmi on 2017/6/9.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ContentVideoCellDelegate

-(void)upDownBtnPressed:(UIButton *)btn;

@end

@interface ContentVideoTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *updownBtn;


@property(nonatomic,weak)id<ContentVideoCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeight_Constraint;

- (IBAction)upDownBtnPressed:(id)sender;

-(void)setCellChangeBig:(BOOL)changeBig withDic:(NSDictionary *)dic;
@end
