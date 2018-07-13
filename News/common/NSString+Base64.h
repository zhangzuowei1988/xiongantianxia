//
//  NSString+Base64.h
//  News
//
//  Created by pdmi on 2017/9/21.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 base64编码

 @return 编码后的字符串
 */
-(NSString *)base64EncodedString;

/**
 base64解码

 @return 解码后的字符串
 */
-(NSString *)base64DecodedString;
@end
