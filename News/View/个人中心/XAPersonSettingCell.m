//
//  XAPersonSettingCell.m
//  News
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAPersonSettingCell.h"
#define margin 15

@implementation XAPersonSettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.itemTitleLabel = [[UILabel alloc] init];
    self.itemTitleLabel.frame = CGRectMake(18, 0, 100, 45);
    self.itemTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    [self.contentView addSubview:self.itemTitleLabel];
    
    self.itemSubTitleTextField = [[UITextField alloc]init];
    self.itemSubTitleTextField.borderStyle = UITextBorderStyleNone;
    self.itemSubTitleTextField.frame = CGRectMake(80, 0, ScreenWidth-120, 45);
    self.itemSubTitleTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.itemSubTitleTextField.textAlignment = NSTextAlignmentRight;
    self.itemSubTitleTextField.textColor = UIColorFromRGB(0x333);
    self.itemSubTitleTextField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:self.itemSubTitleTextField];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_gray_arrow"]];
    arrowImageView.frame = CGRectMake(ScreenWidth-margin-7, (self.height-11)/2.0, 7, 11);
    [self.contentView addSubview:arrowImageView];
    
    self.itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-70, (self.height-30)/2.0, 30, 30)];
    self.itemImageView.layer.cornerRadius = 15;
    self.itemImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.itemImageView];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(15, self.height, ScreenWidth-30, 1)];
    bottomLine.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [self.contentView addSubview:bottomLine];
    
}
@end
