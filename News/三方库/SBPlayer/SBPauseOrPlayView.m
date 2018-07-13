//
//  PauseOrPlayView.m
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/11.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "SBPauseOrPlayView.h"
@interface SBPauseOrPlayView ()
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong) CAGradientLayer *gradientLayer;
@end
@implementation SBPauseOrPlayView

- (instancetype)init
{
    if (self=[super init]) {
        self.thumbImageView=[UIImageView new];
        [self.thumbImageView setHidden:YES];
        [self addSubview:self.thumbImageView];
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.colors = @[(__bridge id)setRGBColor(0, 0, 0, 0.5).CGColor, (__bridge id)setRGBColor(0, 0, 0, 0.2).CGColor, (__bridge id)setRGBColor(0, 0, 0,0.0).CGColor];
        self.gradientLayer.locations = @[@0.0, @0.4, @0.8];
        self.gradientLayer.startPoint = CGPointMake(0.0, 0.0);
        self.gradientLayer.endPoint = CGPointMake(0.0, 0.8);
//        self.gradientLayer.frame = CGRectMake(0,0, 300, 100);
        [self.thumbImageView.layer addSublayer:self.gradientLayer];
        
       // self.maskView=[UIView new];
       // self.maskView.backgroundColor=setRGBColor(0, 0, 0, 0.3);
       // [self.thumbImageView addSubview:self.maskView];
        self.timeLabel=[UILabel new];
        self.timeLabel.backgroundColor=setRGBColor(0, 0, 0, 0.5);
        self.timeLabel.layer.cornerRadius=5;
        self.timeLabel.layer.borderColor=[UIColor clearColor].CGColor;
        self.timeLabel.clipsToBounds=YES;
        self.timeLabel.textColor=[UIColor whiteColor];
        self.timeLabel.font=[UIFont systemFontOfSize:8];
        
        [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
        [self.thumbImageView addSubview:self.timeLabel];
        self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[self.imageBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.imageBtn setImage:[UIImage imageNamed:@"playImage"] forState:UIControlStateNormal];
        [self.imageBtn setShowsTouchWhenHighlighted:YES];
        [self.imageBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
        [self.imageBtn addTarget:self action:@selector(handleImageTapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.imageBtn];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
   
    
    //                    make.top.mas_equalTo([UIApplication sharedApplication].keyWindow).with.offset(0);
    //                    make.left.mas_equalTo([UIApplication sharedApplication].keyWindow).with.offset(0);
    //                    make.right.mas_equalTo([UIApplication sharedApplication].keyWindow).with.offset(0);
    //                    make.height.mas_equalTo([UIApplication sharedApplication].keyWindow.frame.size.height);
    

    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.thumbImageView);
    }];
    self.gradientLayer.frame=self.frame;
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbImageView).with.offset(10);
         make.bottom.mas_equalTo(self.thumbImageView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(45, 10));
        
        
    }];
}
-(void)handleImageTapAction:(UIButton *)button{
    button.selected = !button.selected;
    _state = button.isSelected ? YES : NO;
    if ([self.delegate respondsToSelector:@selector(pauseOrPlayView:withState:)]) {
        [self.delegate pauseOrPlayView:self withState:_state];
    }
}

@end
