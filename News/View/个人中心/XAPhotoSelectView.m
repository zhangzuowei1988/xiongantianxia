//
//  XAPhotoSelectView.m
//  News
//
//  Created by mac on 2018/5/9.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAPhotoSelectView.h"

@interface XAPhotoSelectView()
{
    UIButton *cameraButton;
    UIButton *photoButton;
    UIView *backgroundView;
}
@end

@implementation XAPhotoSelectView

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
    
    cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.frame = CGRectMake(0, 0, backgroundView.width, 51);
    [cameraButton setTitle:@"拍照" forState:UIControlStateNormal];
    [cameraButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cameraButton.tag = 0;
    //    [manButton setTitleColor:UIColorFromRGB(0xd0021b) forState:UIControlStateSelected];
    cameraButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    [cameraButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:cameraButton];
    
    photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    photoButton.frame = CGRectMake(0, 51, backgroundView.width, 51);
    [photoButton setTitle:@"从手机相册选择" forState:UIControlStateNormal];
    [photoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    photoButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    photoButton.tag=1;
    //    [womenButton setTitleColor:UIColorFromRGB(0xd0021b) forState:UIControlStateSelected];
    [photoButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:photoButton];
    
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
    if ([self.delegate respondsToSelector:@selector(photoSelectButtonClick:)]) {
        [self.delegate photoSelectButtonClick:button.tag];
    }
        if (button.tag == 0) {
            self.block(UIImagePickerControllerSourceTypeCamera);
        } else if (button.tag == 1){
            self.block(UIImagePickerControllerSourceTypeSavedPhotosAlbum);
        } else if (button.tag == 2){
    
        }
    [self remove];
}
- (void)gestureTap
{
    [self remove];
}
@end
