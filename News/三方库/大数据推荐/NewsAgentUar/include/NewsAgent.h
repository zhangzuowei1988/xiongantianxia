//
//  NewsAgent.h
//  NewsAgent
//
//  Created by 久其智通 on 2017/12/11.
//  Copyright © 2017年 jiuqizhitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^NewsCallBackBlock)(id response, NSError * error);

@interface NewsAgent : NSObject


/**
 * 设置调试模式，默认为NO
 *
 * @param isDebug 调试模式设置为YES,否则设置成NO
 */
+(void)setDebugMode:(BOOL)isDebug;

+(BOOL)isDebugMode;

/**
 * 开启对程序异常闪退的监控
 */
+(void)onError;



/**
 应用初始化
 
 @param newspot 资讯位 必填
 @param recomName 可选，自定义填 推荐列表控制器类名。 不填填nil。
 @param contentName 可选, 自定义填 详情页控制器类名。 不填填nil
 */
+ (void)registerRecomSpotTag:(NSString *)newspot
                 RecomVCName:(NSString *)recomName
               ContentVCName:(NSString *)contentName;


/**
 快速创建推荐列表，当前列表不会释放
 
 @param RecomName 自定义推荐列表的类名
 @param newsSpotTag 资讯位得名字，可为nil就是你创建的第一个资讯位
 @param contentVCName 自定义详情页的类名
 */
+(void) createRecomViewControllernName:(NSString *)RecomName NewsSpotTag:(NSString*)newsSpotTag contentVCName:(NSString*)contentVCName;

/**
 通过推荐页名字获取控制器
 
 @param name 列表页名字
 @return 列表控制器
 */
+(UIViewController *)getRecomViewController:(NSString*)name;

/**
 * 获取APPKey
 */
+ (NSString *)getAppKey;


/**
 获取当前SDK版本
 
 @return 版本号
 */
+ (NSString *)getSDKVersion;


#pragma mark - 进度条和loading配置


/**
 设置显示进度条和显示菊花，默认都显示，如果不显示请都填NO，此方法需要在初始化register后调用
 
 @param processdisplay 显示进度条
 @param huddisplay 显示菊花
 */
+ (void)setLoadingProcessDisplay:(BOOL)processdisplay HudDisplay:(BOOL)huddisplay;

/**
 设置详情页进度条样式
 
 @param progrocessColor 进度条颜色
 @param height 进度条高度
 */
+ (void)setLoadingColor:(NSString *)progrocessColor loadingHeight:(CGFloat)height;


/**
 设置列表和详情页
 
 @param imagePath 图片的路径
 @param frame 图片的frame，相对于屏幕window
 */
+ (void)setLoadingBackImage:(NSString *)imagePath Frame:(CGRect)frame;


/**
 设置列表和详情页的菊花
 
 @param hudPath 菊花bundle的路径
 @param hudname bundle的名字，如 images.bundle
 @param size 菊花的尺寸，最大为80
 @param time 执行完帧动画所需的时间
 */
+ (void)setLoadingHud:(NSString *)hudPath hudName:(NSString *)hudname hudSize:(CGSize)size hudTimeInterval:(NSTimeInterval )time;

#pragma mark - API接口说明
/**
 查询接口
 
 @param maxcount 请求条数
 @param page 当前页数
 @param search 搜索条件
 @param callback 回调
 */
+ (void)recomApiWithMaxcount:(NSInteger)maxcount
                        Page:(NSInteger)page
                 SearchQuery:(NSString *)search
                    CallBack:(NewsCallBackBlock)callback;

/**
 推荐请求
 
 @param maxcount 请求条数
 @param Duplicat 是否重复
 @param show_model 可回看历史。设置为0时, 表示固定条数, 类似于现汽车报网推荐位形式，每次需保证固定条数，新内容出完会使用推荐历史进行填充，设置为1时，可以支持页面滑动查看历史。;默认为0
 @param max_behot_time 上一条的rec_time。当show_model=1时,-1为查看最新历史,0为获取新内容,
 @param item_id 非必填，相关推荐必填
 @param title 非必填，相关内容推荐
 @param callback 回调
 */
+ (void)recomApiWithMaxcount:(NSInteger)maxcount   //3
               Duplicat_flag:(BOOL)Duplicat        //NO
                  Show_model:(BOOL)show_model       //NO
              Max_behot_time:(NSInteger)max_behot_time //0
                     Item_id:(NSString *)item_id        // nil
                      Titile:(NSString *)title          // nil
                    CallBack:(NewsCallBackBlock)callback;

/**
 负反馈
 
 @param doing 0/1 撤销、发送
 @param item_id 不喜欢内容id
 @param reason 不喜欢原因 reason,quality,keywords:1,2
 @param callback 回调
 */
+ (void)recomNegativeApiWithdo:(NSInteger)doing
                          Item:(NSString *)item_id
                        reason:(NSString *)reason
                      CallBack:(NewsCallBackBlock)callback;
/**
 * App退出时，对相关资源进行释放
 */
/**
 * App退出时，对相关资源进行释放
 */
+(void)onAppEnd;



@end
