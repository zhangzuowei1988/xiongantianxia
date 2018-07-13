//
//  XAClearCacheView.m
//  News
//
//  Created by mac on 2018/5/9.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAClearCacheView.h"

@interface XAClearCacheView()
{
    UIButton *titleButton;
    UIButton *sureButton;
    UIView *backgroundView;
}
@end

@implementation XAClearCacheView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *gestureRecoginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureTap)];
        [self addGestureRecognizer:gestureRecoginzer];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [self addContentView];
    }
    return self;
}
- (void)addContentView
{
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, ScreenWidth, 162)];
    backgroundView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    backgroundView.layer.borderWidth = 1;
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    UIView *seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 102, backgroundView.width, 10)];
    seperateView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [backgroundView addSubview:seperateView];
    
    titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(0, 0, backgroundView.width, 51);
    [titleButton setTitle:@"确定删除所有缓存？" forState:UIControlStateNormal];
    [titleButton setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];
    titleButton.tag = 0;
    //    [manButton setTitleColor:UIColorFromRGB(0xd0021b) forState:UIControlStateSelected];
    titleButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [titleButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:titleButton];
    
    sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(0, 51, backgroundView.width, 51);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    sureButton.tag=1;
    //    [womenButton setTitleColor:UIColorFromRGB(0xd0021b) forState:UIControlStateSelected];
    [sureButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:sureButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, backgroundView.height -51, backgroundView.width, 51);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    cancelButton.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    cancelButton.tag = 2;
    //  [cancelButton setTitleColor:UIColorFromRGB(0xd0021b) forState:UIControlStateSelected];
    [cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:cancelButton];
    
    UIView *seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 51, backgroundView.width, 1)];
    seperateLine.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [backgroundView addSubview:seperateLine];
    
    [UIView animateWithDuration:0.25 animations:^{
        backgroundView.top = self.height-162;
    }];
}
- (void)remove {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        backgroundView.top = self.height;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

#pragma mark - buttonClick
- (void)buttonClicked:(UIButton *)button
{
    if (button.tag == 0) {
    } else if (button.tag == 1){
        self.block();
    } else if (button.tag == 2){
        
    }
    [self remove];
}
- (void)gestureTap
{
    [self remove];
}
@end

