//
//  ISUIViewExt.h
//  iStudy
//
//  Created by SDZN on 15/11/13.
//  Copyright © 2015年 sdzn. All rights reserved.
//

#import <UIKit/UIKit.h>
CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

/**
 平移

 @param delta 平移的点
 */
- (void) moveBy: (CGPoint) delta;

/**
 放大

 @param scaleFactor 放大的比例
 */
- (void) scaleBy: (CGFloat) scaleFactor;

/**
 新的size

 @param aSize 新的size
 */
- (void) fitInSize: (CGSize) aSize;


@end
