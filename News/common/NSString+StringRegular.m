//
//  NSString+StringRegular.m
//  QZ
//
//  Created by luo on 14-10-9.
//  Copyright (c) 2014年 luo. All rights reserved.
//

#import "NSString+StringRegular.h"

@implementation NSString (StringRegular)



+(NSString *)timestampWithString:(NSString*)timestamp {
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:timestamp];;
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
    
}
+(NSString *)bigDataTimestampWithString:(NSString*)timestamp {
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYYMMddHHmm"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:timestamp];;
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
    
}
+ (NSString *)intervalSinceNow: (NSString *) theDate{
    if ([theDate isEqualToString:@""]||theDate==nil) {
        return @"";
    }
    NSString *timeinterVal=[self timestampWithString:theDate];
    
    NSTimeInterval time=0;
    if ([timeinterVal length]>10) {
        time = [[timeinterVal substringToIndex:10] doubleValue];
    }else{
        time=[timeinterVal doubleValue];
    }
    
    NSTimeInterval now= [[NSDate date] timeIntervalSince1970];
    NSString *timeString=@"";
    NSTimeInterval cha=now-time;
    if (cha/60<=3) {
        timeString=@"刚刚";
        
    }else if (cha/3600<1){
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }else if(cha/3600>1&&cha/86400<1){
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }else if(cha/86400>1&&cha/86400<=2){
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = @"1天前";
    }
    else if (cha/86400>2){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormatter stringFromDate:date];
    }
    return timeString;
}

+ (NSString *)intervalSinceInternalNow: (NSString *) inetrnval{
    
    NSString *timeinterVal=inetrnval;
    NSTimeInterval time=0;
    if ([timeinterVal length]>10) {
        time = [[timeinterVal substringToIndex:10] doubleValue];
    }else{
        time=[timeinterVal doubleValue];
    }
    
    NSTimeInterval now= [[NSDate date] timeIntervalSince1970];
    NSString *timeString=@"";
    NSTimeInterval cha=now-time;
    
    if (cha/60<=3) {
        timeString=@"刚刚";
        
    }else if (cha/3600<1){
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }else if(cha/3600>1&&cha/86400<1){
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }else if(cha/86400>1&&cha/86400<=2){
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = @"1天前";
    }
    else if (cha/86400>2){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormatter stringFromDate:date];
    }

    return timeString;
}


+ (NSString *)intervalSinceLast: (NSString *) theDate{
    NSTimeInterval time = [[theDate substringToIndex:10] doubleValue];
    NSTimeInterval now= [[NSDate date] timeIntervalSince1970];;
    NSString *timeString=@"";
    int cha=now-time;
    if (cha/60<1) {
        timeString=@"刚刚更新";
        
    }else if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%d", cha/60];
        timeString=[NSString stringWithFormat:@"上次更新时间：%@分钟前", timeString];
        
        
    }else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%d", cha/3600];
        timeString=[NSString stringWithFormat:@"上次更新时间：%@小时前", timeString];
        
    }else if (cha/86400>1 && cha/86400< 30)
    {
        timeString = [NSString stringWithFormat:@"%d", cha/86400];
        timeString=[NSString stringWithFormat:@"上次更新时间：%@天前", timeString];
        
    }else if (cha/86400>30)
    {
        timeString = [NSString stringWithFormat:@"%d", cha/(86400*30)];
        timeString=[NSString stringWithFormat:@"上次更新时间：%@月前", timeString];
        
        
    }
    return timeString;
}
+(NSString *)timeFormatWithString:(NSString*)timestamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timestamp];
    [formatter setDateFormat:@"MM-dd HH:mm"];
   
    NSString *dateStr=[formatter stringFromDate:date];
    return  dateStr;
    
}

+(NSString *)timeFormatWithCommnadString:(NSString*)timestamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHmm"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timestamp];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *dateStr=[formatter stringFromDate:date];
    return  dateStr;
}
+(NSString *)timeFormatWithVideoString:(NSString*)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    
    
    NSString *dateStr=[formatter stringFromDate:date];
    return  dateStr;
}
@end
