//
//  ColumnModel.m
//  News
//
//  Created by pdmi on 2017/6/12.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "ColumnModel.h"

@implementation ColumnModel

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


@end
