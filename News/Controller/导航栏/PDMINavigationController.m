//
//  TTNavigationController.m
//  TTNews
//
//  Created by 瑞文戴尔 on 16/3/25.
//  Copyright © 2016年 瑞文戴尔. All rights reserved.
//

#import "PDMINavigationController.h"
//#import "UINavigationController+GKRotation.h"
//#import "TTConst.h"
//#import <DKNightVersion.h>
//#import <SDImageCache.h>
@interface PDMINavigationController ()

@end

@implementation PDMINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
   
    UIImage *img = [self createImageWithColor:[CommData shareInstance].skinColor size:CGSizeMake(1, 1)];
    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
   
   // [self.navigationBar setBarTintColor:[UIColor colorWithPatternImage:img]];
   
    [self.navigationBar  setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                       NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                                       }];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
   // self.navigationBar.translucent=NO;

}

-(UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
//
////UINavigationBar+Color
//- (void)KPSetBackgroundColor:(UIColor*)color
//{
//    UIImage *img = [KPAppImage createImageWithColor:color size:CGSizeMake(1, 1)];
//    [self setBackgroundImage: forBarMetrics:UIBarMetricsDefault];
//}


//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)){
//        self.navigationBar.translucent = NO;
//    }
//}
-(void)dealloc {
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigationbar_pic_back_icon"] forState:UIControlStateNormal];
       // [button setImage:[UIImage imageNamed:@"navigationbar_back_icon"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 30, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button sizeToFit];
        // 让按钮的内容往左边偏移10
//        button.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);

        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    

}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}


- (void)back
{
    [self popViewControllerAnimated:YES];
}

-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

@end
