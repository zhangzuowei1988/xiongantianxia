//
//  magent.h
//  magent
//
//  Created by 傅士光 on 15/3/15.
//  Copyright (c) 2015年 com.zdata.sys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MAgent : NSObject
/**
 *  初始化sdk，需要在ios的
 xxxAppDelegate.m 的 didFinishLaunchingWithOptions 函数中调用
 */
+ (void)start;
/**
 *  设置当前操作的用户id
 *
 *  @param userId userId 用户ID
 */
+ (void)setUserId:(NSString*)userId userIdType:(NSString *)userIdType;
/**
 *  清除当前用户id，如当用户退出时调用
 */
+ (void)clearUserId;
/**
 *  设置调试模式，调试模式时会打印出log信息，默认false
 */
+ (void)setDebugMode:(bool)isDebugMode;
+ (void)startMonitorButtonClick:(UIView *)view;
/**
 *  页面开始展现
 *
 *  @param page page 页面名称,不同页面需唯一
 */
+ (void)startPageView:(NSString*)page;
+ (void)startPageView:(NSString*)page title:(NSString *)title uri:(NSString *)uri itemid:(NSString *)itemid;

/**
 *  页面结束展现
 *
 *  @param page page 页面名称
 */
+ (void)endPageView:(NSString*)page;
/**
 *  计次事件
 *
 *  @param eventTag 事件的tag，需在web端事先添加
 */
+ (void)onEvent:(NSString*)eventTag;
+ (void)onEvent:(NSString*)eventTag title:(NSString *)title uri:(NSString *)uri itemid:(NSString *)itemid;

/**
 *  计次，带属性的事件，后台将可以按照属性进行区分统计
 *
 *  @param eventTag   事件的tag
 *  @param attributes 属性字典，如@{@"type":@"book", @"kind":@"novel"}
 */
+ (void)onEvent:(NSString*)eventTag attributes:(NSDictionary*)attributes;
+ (void)onEvent:(NSString*)eventTag attributes:(NSDictionary*)attributes title:(NSString *)title uri:(NSString *)uri itemid:(NSString *)itemid;

/**
 *  计次，带属性的事件，后台将可以按照属性进行区分统计，并可以统计出不同属性事件的值的分布，如小说类图书订单一般出现在什么单笔销售额区间
 *
 *  @param eventTag     eventTag description
 *  @param attributes   attributes description
 *  @param computeValue computeValue description
 */
+ (void)onEvent:(NSString*)eventTag attributes:(NSDictionary*)attributes computeValue:(int)computeValue;
+ (void)onEvent:(NSString*)eventTag attributes:(NSDictionary*)attributes computeValue:(int)computeValue title:(NSString *)title uri:(NSString *)uri itemid:(NSString *)itemid;

/**
 *  持续性事件的开始
 *
 *  @param eventTag 事件的tag
 */
+ (void)onEventStart:(NSString *)eventTag;
+ (void)onEventStart:(NSString *)eventTag title:(NSString *)title uri:(NSString *)uri itemid:(NSString *)itemid;

/**
 *  持续性事件的开始，带属性集合
 *
 *  @param eventTag   事件的tag
 *  @param attributes 事件的属性集合
 */
+ (void)onEventStart:(NSString *)eventTag attributes:(NSDictionary*)attributes;
+ (void)onEventStart:(NSString *)eventTag attributes:(NSDictionary*)attributes title:(NSString *)title uri:(NSString *)uri itemid:(NSString *)itemid;

/**
 *  持续性事件的结束
 *
 *  @param eventTag 事件的tag
 */
+ (void)onEventEnd:(NSString*)eventTag;

/**
 *  错误监测
 */
+ (void)onError;

/**
 *  结束函数，需要在ios的
 xxxAppDelegate.m 的 applicationWillTerminate 函数中调用
 */
+ (void)onAppEnd;

// 手动设置appkey,需要放在初始化之前生效,
+ (void)setAppkey:(NSString *)appkey;

// 获取uuid
+ (NSString *)getUUID;

// 推荐点击
+ (void)onClick:(NSString*)eventTag title:(NSString *)title uri:(NSString *)uri itemid:(NSString *)itemid adspot:(NSString*)adspot req_info:(NSString*)reqInfo cl:cl token:token;



@end
