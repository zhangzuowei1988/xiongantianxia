//
//  NSString+SHEmoji.h
//  emojiDemo
//
//  Created by LHL on 16/4/22.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>



@interface NSString (md5)

/**
 MD5加密

 @return MD5加密后的字符串
 */
-(NSString *) md5HexDigest;

@end
