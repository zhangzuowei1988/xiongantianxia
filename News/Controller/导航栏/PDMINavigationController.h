//
//  TTNavigationController.h
//  TTNews
//
//  Created by 瑞文戴尔 on 16/3/25.
//  Copyright © 2016年 瑞文戴尔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDMINavigationController : UINavigationController

/**
 推出新的导航控制器

 @param viewController 需要显示的导航控制器
 @param animated 是否以动画的方式显示
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end
