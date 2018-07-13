//
//  XAPersonCenterCell.m
//  News
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAPersonCenterCell.h"
#define margin 15
@implementation XAPersonCenterCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addContentView];
    }
    return self;
}

- (void)addContentView
{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 150, self.height)];
    self.titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-36-150, 0, 150, self.height)];
    self.rightLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:self.rightLabel];
    
    UIImageView *rightArrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-margin-7, (self.height-11)/2.0, 7, 11)];
    rightArrowImageView.image = [UIImage imageNamed:@"right_gray_arrow"];
    [self.contentView addSubview:rightArrowImageView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(margin, self.height-1, ScreenWidth-margin*2, 1)];
    bottomView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [self.contentView addSubview:bottomView];
}
@end
