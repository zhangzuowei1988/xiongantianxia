//
//  ZJTagHeaderView.m
//  ZJTagView
//
//  Created by ZeroJ on 16/10/24.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "PDMITagHeaderView.h"

@implementation PDMITagHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(11, 0, 58, self.height);
    self.subTitleLabel.frame = CGRectMake(79, 0, 100, self.height);
}
-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.backgroundColor = [CommData shareInstance].configModel.columnBackgroundColor;
        titleLabel.textColor = UIColorFromRGB(0x888888);
        titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:[CommData shareInstance].scale*FourthTitleFontSize];
        //        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        _subTitleLabel = titleLabel;
    }
    return _subTitleLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.backgroundColor = [CommData shareInstance].configModel.columnBackgroundColor;
        titleLabel.textColor = [CommData shareInstance].commonBlackColor;
        titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:[CommData shareInstance].scale*ThirdTitleFontSize];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
@end
