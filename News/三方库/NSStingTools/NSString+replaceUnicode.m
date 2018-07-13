//
//  NSString+replaceUnicode.m
//  CiticMovie
//
//  Created by fuqiang on 12/9/13.
//  Copyright (c) 2013 fuqiang. All rights reserved.
//

#import "NSString+replaceUnicode.h"

@implementation NSString (replaceUnicode)


/**
 *  替换Unicode码
 *
 *  @return 字符串编字符串
 */
- (NSString *)replaceUnicode
{
    NSString *tempStr1  = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2  = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3  = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData   *tempData  = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

@end
