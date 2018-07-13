//
//  NSDictionary+URLParam.m
//  CiticMovie
//
//  Created by fuqiang on 12/9/13.
//  Copyright (c) 2013 fuqiang. All rights reserved.
//

#import "NSDictionary+URLParam.h"

@implementation NSDictionary (URLParam)

/**
 *  根据字典拼http GET 请求参数
 *
 *  @return 请求参数字符串
 */
- (NSString *)URLParam
{
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        NSString *strKey = key;
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *strObj = obj;
            [mutableString appendString:strKey];
            [mutableString appendString:@"="];
            [mutableString appendString:strObj];
            [mutableString appendString:@"&"];
        }
        if ([obj isKindOfClass:[NSMutableArray class]]||[obj isKindOfClass:[NSArray class]]) {
            NSArray * arrObj =(NSArray*)obj;

            [mutableString appendString:strKey];
            [mutableString appendString:@"="];
            [mutableString appendString:@"['"];
            
            NSString *string = [arrObj componentsJoinedByString:@"','"];
            [mutableString appendString:string];
            
            [mutableString appendString:@"']"];

            [mutableString appendString:@"&"];
        }
        
    }];
    
    if (mutableString.length > 0)
    {
        if ([[mutableString substringFromIndex:(mutableString.length - 1)] isEqualToString:@"&"])
        {
            [mutableString deleteCharactersInRange:NSMakeRange(mutableString.length - 1, 1)];
        }
    }
    
    return mutableString;
}

@end
