//
//  ContentPicZoomView.h
//  News
//
//  Created by pdmi on 2017/5/31.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentPicZoomView : BaseView<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain)UIView *containerView;
@property (nonatomic, assign) BOOL isViewing;

/**
 重置frame

 @param newFrame 新的frame
 */
- (void)resetViewFrame:(CGRect)newFrame;

/**
 更新图片

 @param imgUrl 新的图片URL
 */
- (void)uddateImageWithUrl:(NSString *)imgUrl;
@end
