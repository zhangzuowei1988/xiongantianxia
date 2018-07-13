//
//  WorkRoomNetWork.h
//  WorkRoom
//
//  Created by pdmi on 2017/2/13.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

typedef void(^NewsCompleteBlock)(id result);
typedef void(^NewsErrorBlock)(NSError *error);

@interface NewsNetWork : NSObject
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic,strong)AFURLSessionManager *manager ;
+(NewsNetWork *)shareInstance;


/**
 获取短信验证码

 @param dic 参数手机号
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)getPhoneCodeWithDic:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;

/**
 短信验证码登录

 @param dic 参数手机号和验证码
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)loginWithPhoneCodeDic:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;

/**
 修改个人信息

 @param dic 需要修改的字段
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)updatePersonInfomation:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;


/**
 修改个人头像

 @param dic 参数头像数据
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)updatePersonPhotoWithDic:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;


/**
 获取个人信息

 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)getPersonInformationWithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;

/**
 下载附件

 @param fileUrl 附件的URL链接
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
- (void)downLoadFileWithUrl:(NSString*)fileUrl withComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;


/**
 获取首页列表

 @param link URL链接
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)getMainListWithLink:(NSString *)link WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;

/**
 获取大数据列表 下拉刷新

 @param tagName 大数据栏目名称
 @param isFirst 页面是否是第一次下载
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)getBigDataListWithTagName:(NSString *)tagName isFirst:(BOOL)isFirst WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;


/**
 大数据加载更多

 @param tagName 大数据栏目的名称
 @param recTime 上一页最后一条数据的推荐时间
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)getBigDataListWithTagName:(NSString *)tagName recTime:(NSNumber*)recTime WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;


/**
 网络get请求的封装

 @param link URL链接
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)getArticleContentWithLink:(NSString *)link WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;




/**
 获取新闻栏目配置文件

 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)getConfigureWithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;

- (AFHTTPRequestOperation *)requestWithParm:(NSMutableDictionary *)requestParam
                                    success:(void (^)(AFHTTPRequestOperation *operation, id result))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark -get 请求

/**
 对get请求封装

 @param jsondic 请求参数
 @param requestUrl 请求URL
 @param completeBlock 网络请求成功回调
 @param errorBlock 网络请求失败回调
 */
-(void)setRequestGetWithJsonData:(NSDictionary *)jsondic requestUrl:(NSString *)requestUrl WithComplete:(NewsCompleteBlock)completeBlock  error:(NewsErrorBlock)errorBlock;

@end

