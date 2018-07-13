//
//  XAProgressHUD.m
//  News
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAProgressHUD.h"

@implementation XAProgressHUD
#pragma mark - 活动指示器相关
+ (void)showMBProgressHUDOnView:(UIView *)view onlyLabelText:(NSString *)aText{
    MBProgressHUD *mbpView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbpView.mode = MBProgressHUDModeText;
    mbpView.labelText = aText;
}
+ (void)showMBProgressHUDOnView:(UIView *)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}
+ (void)hiddenMBProgressHUDOnView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
+ (void)showMBProgressHUDOnView:(UIView *)view onlyLabelText:(NSString *)aText AfterSecond:(CGFloat)seconds
{
    [self showMBProgressHUDOnView:view onlyLabelText:aText];
    //设置时间为2
    double delayInSeconds = seconds;
    //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //推迟两纳秒执行
    dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^(void){
        [self hiddenMBProgressHUDOnView:view];
    });
}
@end
