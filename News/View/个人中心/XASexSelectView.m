//
//  XASexSelectView.m
//  News
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XASexSelectView.h"

@interface XASexSelectView()
{
    UIButton *manButton;
    UIButton *womenButton;
    UIView *backgroundView;
}
@end

@implementation XASexSelectView

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
    
    manButton = [UIButton buttonWithType:UIButtonTypeCustom];
    manButton.frame = CGRectMake(0, 0, backgroundView.width, 51);
    [manButton setTitle:@"男" forState:UIControlStateNormal];
    [manButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    manButton.tag = 0;
//    [manButton setTitleColor:UIColorFromRGB(0xd0021b) forState:UIControlStateSelected];
    manButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    [manButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:manButton];
    
    womenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    womenButton.frame = CGRectMake(0, 51, backgroundView.width, 51);
    [womenButton setTitle:@"女" forState:UIControlStateNormal];
    [womenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    womenButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    womenButton.tag=1;
//    [womenButton setTitleColor:UIColorFromRGB(0xd0021b) forState:UIControlStateSelected];
    [womenButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:womenButton];

    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, backgroundView.height-51, backgroundView.width, 51);
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
-(void)setSex:(NSString *)sex
{
    _sex = sex;
    if (_sex) {
        [womenButton setBackgroundColor:[UIColor whiteColor]];
        [womenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [manButton setBackgroundColor:[UIColor whiteColor]];
        [manButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    if ([_sex isEqualToString:@"男"]) {
        [manButton setBackgroundColor:UIColorFromRGB(0xd0021b)];
        [manButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if ([_sex isEqualToString:@"女"]) {
        [womenButton setBackgroundColor:UIColorFromRGB(0xd0021b)];
        [womenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
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
    if ([self.delegate respondsToSelector:@selector(sexSelectButtonClick:)]) {
        [self.delegate sexSelectButtonClick:button.tag];
    }
    if (button.tag == 0) {
        self.block(@"男");
    } else if (button.tag == 1){
        self.block(@"女");
    } else if (button.tag == 2){
    }
    [self remove];
}
- (void)gestureTap
{
    [self remove];
}
@end
