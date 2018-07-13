//
//  AppDelegate.m
//  News
//
//  Created by pdmi on 2017/5/17.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "AppDelegate.h"
#import "PDMITabBarController.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UserNotifications/UserNotifications.h>
#import "PDMISandboxFile.h"
#import "XANewsRecomViewController.h"
#import "NewsAgent.h"

#import "DHGuidePageHUD.h"
#define BOOLFORKEY @"dhGuidePage"
#import "PDMIDeviceInfo.h"
#import <Bugly/Bugly.h>
#import "MTAAutoTrack.h"
#import "MTA.h"
#import "MTAConfig.h"
//广告
#import "AppDelegate+XHLaunchAd.h"

#import "MAgent.h"
//BMKMapManager* _mapManager;
@interface AppDelegate ()<UNUserNotificationCenterDelegate>{
    NSDictionary *buildDic;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *settingJson=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"configure/build" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
      buildDic=[settingJson JSONObject];
    //友盟分享
    [self confitUShareSettings];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    PDMITabBarController *tabBarController=[[PDMITabBarController alloc] init];
    NewsUserModel *model=[[CommData shareInstance] getUserMessageModel];
    if (model!=nil&&model.loginkey!=nil) {
        [CommData shareInstance].userModel=model;
        [CommData shareInstance].isLogin=YES;
        }
     self.window.rootViewController =tabBarController;
    [self.window makeKeyAndVisible];
    //更新新闻栏目
    [[NewsNetWork shareInstance] getConfigureWithComplete:^(id result) {
        
    } withErrorBlock:^(NSError *error) {
        
    }];
    //大数据配置
    [self setCommndView];
    [Bugly startWithAppId:Bugly_ID];
    [MTA startWithAppkey:@"ID49FYWJ58EZ"];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // 统计应用时长,结束时打点
    [MTA trackActiveEnd];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 统计应用时长,开始时打点
    [MTA trackActiveBegin];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 可视化埋点代码
    // 若不使用可视化埋点功能
    // 可不添加这行代码
    if ([MTAAutoTrack handleAutoTrackURL:url])
        return YES;
    // 原有代码
    return NO;
}
#pragma mark -  设置启动时间
-(void)setStartTime{
    [CommData shareInstance].startTime=[[NSDate new] timeIntervalSince1970];
}

#pragma mark - 设置引导页面
-(void)setGuideView{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 静态引导页
        [self setStaticGuidePage];
        
    }
    
   
    
}
#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    
  
    
    NSMutableArray *imageNameArray;
    
    if (iPhone4&&[buildDic objectForKey:@"splash35"]!=[NSNull null]&&[[buildDic objectForKey:@"splash35"] count]!=0) {
        
        imageNameArray=[self resetGuideArr:[buildDic objectForKey:@"splash35"]];
        
        
    }else if (iPhone5&&[buildDic objectForKey:@"splash40"]!=[NSNull null]&&[[buildDic objectForKey:@"splash40"] count]!=0){
        
        imageNameArray=[self resetGuideArr:[buildDic objectForKey:@"splash40"]];
        
    }else if (iPhone678Plus&&[buildDic objectForKey:@"splash55"]!=[NSNull null]&&[[buildDic objectForKey:@"splash55"] count]!=0){
        
        imageNameArray=[self resetGuideArr:[buildDic objectForKey:@"splash55"]];
        
    }else if (iPhoneX&&[buildDic objectForKey:@"splashX"]!=[NSNull null]&&[[buildDic objectForKey:@"splashX"] count]!=0){
        
        imageNameArray=[self resetGuideArr:[buildDic objectForKey:@"splashX"]];
        
    }
    else{
        
        imageNameArray=[self resetGuideArr:[buildDic objectForKey:@"splash47"]];
    }

    
   // NSArray *imageNameArray = @[@"guide1",@"guide2"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height) imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = NO;
    [[UIApplication sharedApplication].delegate.window addSubview:guidePage];
    // [self.navigationController.view addSubview:guidePage];
}
-(NSMutableArray *)resetGuideArr:(NSArray *)guideImageArr{
        
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [guideImageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject:[NSString stringWithFormat:@"configure/splash/%@",obj]];
        }];
        return arr;
}

//设置大数据
-(void)setCommndView{

    [MAgent start];
    [MAgent onError];
    if ([CommData shareInstance].isLogin) {
        [MAgent setUserId:[CommData shareInstance].userModel.mobilephone userIdType:@"1"];
    } else {
        [MAgent setUserId:nil userIdType:nil];
    }
}

#pragma mark - 分享
- (void)confitUShareSettings{
    
    
    [[UMSocialManager defaultManager]setUmSocialAppkey:[buildDic objectForKey:@"umengAppKey"]];
    
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;

   
    [[UMSocialManager defaultManager] openLog:YES];
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:[buildDic objectForKey:@"weixinAppKey"]  appSecret:[buildDic objectForKey:@"weixinAppSecret"] redirectURL:nil];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:[buildDic objectForKey:@"qqAppId"]/*设置QQ平台的appID*/  appSecret:[buildDic objectForKey:@"qqAppKey"] redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     设置新浪的appKey和appSecret@"http://www.hubpd.com"
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:[buildDic objectForKey:@"sinaAppkey"]  appSecret:[buildDic objectForKey:@"sinaAppSecret"] redirectURL:@"https://sns.whalecloud.com/sina2/callback"];


}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
     NSLog(@"ddd");
}

- (void)applicationWillTerminate:(UIApplication *)application {
//    大数据
    [MAgent onAppEnd];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {

    return UIInterfaceOrientationMaskAll;
}

@end
