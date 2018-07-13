//
//  VersionModel.m
//  News
//
//  Created by pdmi on 2017/7/5.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "VersionModel.h"

@implementation VersionModel
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
    
    if ([key isEqualToString:@"config"]) {
        ConfigModel *model=[[ConfigModel alloc] initWithDictionary:value];
        self.configModel=model;
    }else if ([key isEqualToString:@"tabs"]){
        NSArray *arr=value;
        NSMutableArray *modelArr=[[NSMutableArray alloc] init];
        for (int i=0; i<[arr count]; i++) {
            NSDictionary *dic=[arr objectAtIndex:i];
            PageModel *model=[[PageModel alloc] initWithDictionary:dic];
            [modelArr addObject:model];
        }
        self.pages=modelArr;
    }else{
    
    [super setValue:value forKey:key];
    }
}

@end
