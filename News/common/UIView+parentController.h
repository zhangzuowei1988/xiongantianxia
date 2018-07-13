//
//  UIView+parentController.h
//  News
//
//  Created by pdmi on 2017/5/25.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (parentController)

/**
 获取视图的控制器

 @return 视图控制器
 */
- (UIViewController *)parentController;
@end
