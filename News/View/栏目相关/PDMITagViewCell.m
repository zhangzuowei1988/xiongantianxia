//
//  ZJTagViewCell.m
//  ZJTagView
//
//  Created by ZeroJ on 16/10/24.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "PDMITagViewCell.h"
@interface PDMITagViewCell()

@end

@implementation PDMITagViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.delButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 8, self.frame.size.width-8, self.frame.size.height-8);
    self.delButton.frame=CGRectMake(self.frame.size.width-16, 0, 16, 16);
}

- (void)setInEditState:(BOOL)inEditState {
    _inEditState = inEditState;
//    if (inEditState) {
//       // self.titleLabel.backgroundColor = [UIColor redColor];
//
//        self.delButton.hidden=NO;
//    }
//    else {
//        self.delButton.hidden=YES;
//       // self.titleLabel.backgroundColor = [UIColor blueColor];
//    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, self.frame.size.width-7, self.frame.size.height-7)];
        titleLabel.font=[UIFont systemFontOfSize:[CommData shareInstance].scale*ThirdTitleFontSize];
        titleLabel.textColor = [CommData shareInstance].commonBlackColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.layer.cornerRadius=3.0;
        titleLabel.layer.borderWidth = 1;
        UIColor *borderColor = UIColorFromRGB(0xe5e5e5);
        titleLabel.layer.borderColor = borderColor.CGColor;
        titleLabel.clipsToBounds = YES;
        _titleLabel = titleLabel;

        self.delButton=[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-16,5, 16, 16)];
        [self.delButton setUserInteractionEnabled:NO];
        [self.delButton setImage:[UIImage imageNamed:@"del_channels"] forState:UIControlStateNormal];
    }
    
    return _titleLabel;
}
@end
