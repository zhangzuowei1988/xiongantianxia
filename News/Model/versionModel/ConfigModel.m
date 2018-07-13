//
//  ConfigModel.m
//  News
//
//  Created by pdmi on 2017/7/5.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "ConfigModel.h"

@implementation ConfigModel

- (instancetype)initWithDictionary:(NSDictionary *)dict

{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
    
}

+ (instancetype)provinceWithDictionary:(NSDictionary *)dict

{
    
    return [[self alloc] initWithDictionary:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}
- (void)setNilValueForKey:(NSString *)key{
    
}
-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"appStructure"]) {
        [super setValue:value forKey:key];
    }else{
        value=[self toUIColorByStr:value];
        [super setValue:value forKey:key];
    }
    
}
-(UIColor*)toUIColorByStr:(NSString*)colorStr{
    
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }else if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    
    
    
    if ([cString length] != 6){
        return [UIColor blackColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
