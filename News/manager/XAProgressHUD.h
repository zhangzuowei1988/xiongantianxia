//
//  XAProgressHUD.h
//  News
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface XAProgressHUD : NSObject
#pragma mark - 活动指示器相关


/**
 显示活动指示器

 @param view 现在在那个view上
 @param aText 显示的字符串
 */
+ (void)showMBProgressHUDOnView:(UIView *)view onlyLabelText:(NSString *)aText;

/**
 显示在那个view上

 @param view 需要显示的view
 */
+ (void)showMBProgressHUDOnView:(UIView *)view;


/**
 显示活动指示器，几秒后消失

 @param view 需要显示的view
 @param aText 显示的字符串
 @param seconds 多少时间自动消失
 */
+ (void)showMBProgressHUDOnView:(UIView *)view onlyLabelText:(NSString *)aText AfterSecond:(CGFloat)seconds;

/**
 隐藏活动指示器

 @param view 显示在的view
 */
+ (void)hiddenMBProgressHUDOnView:(UIView *)view;
@end
