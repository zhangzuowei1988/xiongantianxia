//
//  XANewsBaseCell.m
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANewsBaseCell.h"

@implementation XANewsBaseCell
- (void)addContentView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.leftImageView  = [[UIImageView alloc]init];
    self.leftImageView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.leftImageView.clipsToBounds = YES;
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.leftImageView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.statusLabel = [[UILabel alloc]init];
    self.statusLabel.textColor = UIColorFromRGB(0xff4d4d);
    self.statusLabel.layer.cornerRadius = 2;
    self.statusLabel.clipsToBounds = YES;
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.layer.borderColor = UIColorFromRGB(0xff4d4d).CGColor;
    self.statusLabel.layer.borderWidth = 1;
    self.statusLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.contentView addSubview:self.statusLabel];
    
    self.releaseFromLabel = [[UILabel alloc]init];
    self.releaseFromLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
    self.releaseFromLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.contentView addSubview:self.releaseFromLabel];
    
    self.bottomLine = [[UIView alloc]init];
    self.bottomLine.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [self.contentView addSubview:self.bottomLine];
    
    self.specialSubjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 51, 25)];
    self.specialSubjectLabel.text  = @"专题";
    self.specialSubjectLabel.backgroundColor = UIColorFromRGB(0xff4d4d);
    self.specialSubjectLabel.textAlignment = NSTextAlignmentCenter;
    self.specialSubjectLabel.clipsToBounds = YES;
    self.specialSubjectLabel.layer.cornerRadius = 3;
    self.specialSubjectLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.specialSubjectLabel.textColor = [UIColor whiteColor];
    self.specialSubjectLabel.hidden = YES;
    [self.contentView addSubview:self.specialSubjectLabel];
}

@end
