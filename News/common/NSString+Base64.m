//
//  NSString+Base64.m
//  News
//
//  Created by pdmi on 2017/9/21.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)
-(NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
    
}
-(NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
  
}

@end
