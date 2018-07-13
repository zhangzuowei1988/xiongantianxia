//
//  XANewsShareManager.h
//  News
//
//  Created by mac on 2018/5/11.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <UShareUI/UShareUI.h>

@interface XANewsShareManager : NSObject

/**
 创建单例

 @return 返回XANewsShareManager单例
 */
+ (XANewsShareManager*)defaultManager;

/**
 调友盟的分享面板

 @param newsTitle 分享标题
 @param newsContent 分享内容
 @param thumbImg 分享图片
 @param newsLink 分享链接
 @param currentViewController 当前控制器
 */
- (void)shareNewsWithTitle:(NSString*)newsTitle newsContent:(NSString*)newsContent thumbImg:(NSString*)thumbImg newsLink:(NSString*)newsLink viewController:(UIViewController*)currentViewController;
@end
