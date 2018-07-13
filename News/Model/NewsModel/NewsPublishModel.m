//
//  NewsPublishModel.m
//  News
//
//  Created by pdmi on 2017/7/4.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "NewsPublishModel.h"

@implementation NewsPublishModel

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
    [super setValue:value forKey:key];
}

@end
