//
//  NSString+StringRegular.h
//  QZ
//
//  Created by luo on 14-10-9.
//  Copyright (c) 2014年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringRegular)

-(NSMutableArray *)substringByRegular:(NSString *)regular;

/**
 时间格式转换

 @param theDate 当前日期
 @return 转换后的日期
 */
+ (NSString *)intervalSinceNow: (NSString *) theDate;

/**
 时间格式转换

 @param theDate 上次更新日期
 @return 转换后的日期

 */
+ (NSString *)intervalSinceLast: (NSString *) theDate;

/**
 大数据时间格式转换

 @param timestamp 时间戳
 @return 转换后的日期格式
 */
+(NSString *)bigDataTimestampWithString:(NSString*)timestamp;

/**
 时间格式转换

 @param inetrnval 时间戳字符串
 @return 转换后的时间格式
 */
+ (NSString *)intervalSinceInternalNow: (NSString *) inetrnval;
/**
 时间格式转换@"MM-dd HH:mm"
 
 @param timestamp 时间戳字符串
 @return 转换后的时间格式
 */
+(NSString *)timeFormatWithString:(NSString*)timestamp;

/**
 时间格式转换YYYY-MM-dd HH:mm:ss
 
 @param timestamp 时间戳字符串
 @return 转换后的时间格式
 */
+(NSString *)timeFormatWithCommnadString:(NSString*)timestamp;
/**
 时间格式转换 YYYY-MM-dd HH:mm
 
 @param timestamp 时间戳字符串
 @return 转换后的时间格式
 */
+(NSString *)timeFormatWithVideoString:(NSString*)timestamp;

@end
