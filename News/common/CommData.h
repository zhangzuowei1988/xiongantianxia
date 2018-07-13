//
//  CommData.h
//  WorkRoom
//
//  Created by pdmi on 2017/2/15.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import "ConfigModel.h"
#import "VersionModel.h"
#import "NewsUserModel.h"

typedef  NS_ENUM(NSInteger,NewsCellPicType)
{
    NewsCellPicTypeLeft,//左图右文
    NewsCellPicTypeTop,//上图下文
    NewsCellPicTypeNone,//没有图片
    NewsCellPicTypeThree,//三张图片
};

typedef  NS_ENUM(NSInteger,NewsType)
{
    NewsTypeNone,
    NewsTypeAtricle,//文章
    NewsTypePictures,//图集
    NewsTypeTopic,//专题
    NewsTypeVideo,//三张图片
};
@interface CommData : NSObject

@property(nonatomic,strong)NSMutableArray *orderedData;
@property(nonatomic,strong)NSMutableDictionary *readedData;
@property(nonatomic)float scale;
@property(nonatomic)float percent;
@property(nonatomic,strong)ConfigModel *configModel;
@property(nonatomic,strong)VersionModel *verisionModel;
@property(nonatomic,strong)NewsUserModel *userModel;
@property(nonatomic,strong)UIColor *skinColor;
@property(nonatomic)BOOL isLogin;
@property(nonatomic)BOOL changYanLogin;
@property(nonatomic)BOOL isNight;
@property(nonatomic,assign)BOOL isFirstLoadWebView;
@property(nonatomic,strong)CAGradientLayer  *gradientLayer;
@property(nonatomic,strong)UIImage *placeholderImage;


@property(nonatomic,strong)UIImage *placeHolderOrgheaderImage;


@property(nonatomic,strong)UIColor *commonBlackColor;
@property(nonatomic,strong)UIColor *commonLightBlackColor;
@property(nonatomic,strong)UIColor *commonGrayColor;
@property(nonatomic,strong)UIColor *commonLightGrayColor;

@property(nonatomic,strong)UIColor *commonGroundViewColor;
@property(nonatomic,strong)UIColor *commonBorderColor;

@property(nonatomic,strong)UIColor *commonBottomViewColor;

@property(nonatomic)CGFloat commonLeftMargin;
@property(nonatomic)CGFloat commonRightMargin;

@property(nonatomic)NSTimeInterval startTime;

+(CommData *)shareInstance;


/**
 获取已经订阅的栏目列表


 @param tabId tabbarId
 @return 新闻栏目
 */
-(NSArray *)getOrderedColumnDataWithTabId:(NSString *)tabId;

/**
 本地存储新闻栏目

 @param orderArr 需要存储的栏目
 @param tabId tabbarID
 @return 是否存储成功
 */
-(BOOL)saveOrderedColumnData:(NSArray *)orderArr withTabId:(NSString *)tabId;





/**
 获取配置json文件路径

 @return 路径
 */
-(NSString *)getConfigureJsonPath;
/**
 获取配置图片文件路径
 
 @return 路径
 */

-(NSString *)getConfigureImagePath;
/**
 获取配置文件路径
 
 @return 路径
 */

-(NSString *)getConfigurePath;
/**
 获取Temp文件路径
 
 @return 路径
 */

-(NSString *)getConfigureTempPath;


/**
 解压缩配置文件

 @param zipPath 压缩的路径
 @return 是否压缩成功
 */
-(BOOL)unzipConfigureFileAtPath:(NSString *)zipPath;



/**
 存储个人登录信息

 @param model 个人信息model
 @return 是否存储成功
 */
-(BOOL)saveUserMessageWithModel:(NewsUserModel *)model;


/**
 获取个人用户信息

 @return 个人信息model
 */
-(NewsUserModel *)getUserMessageModel;

//弹框

/**
 显示弹窗

 @param message 弹窗显示信息
 @return alert控制器
 */
-(UIAlertController *)alertWithMessage:(NSString*)message;
#pragma mark - encode

/**
 设置字体

 @param size 字体大小
 @return 处理后的字体
 */
-(UIFont*)setLabelFountWithSize:(CGFloat)size;



/**
 获取新闻栏目

 @return 新闻栏目数组
 */
-(NSMutableArray *)getHotspotData;

/**
 存储新闻栏目

 @param orderArr 新闻栏目数组
 */
-(void)saveHotspotData:(NSMutableArray *)orderArr;

/**
 获取占位图

 @param imageSize 占位图大小
 @return 生成的占位图
 */
- (UIImage *)getPlaceHoldImage:(CGSize)imageSize;

/**
 把用户信息存储到本地

 @param dict 用户信息
 */
-(void)saveUserInfoData:(NSDictionary *)dict;

/**
 获取本地的用户信息

 @return 用户信息
 */
-(NSDictionary*)getUserInfoData;



/**
 获取设备网络状态

 @return 设备当前的网络状态
 */
+ (NSString *)deviceNetWorkStatus;
@end
