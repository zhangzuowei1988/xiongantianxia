//
//  TopicModel.m
//  News
//
//  Created by pdmi on 2017/6/12.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "TopicModel.h"
#import "ColumnModel.h"
@implementation TopicModel
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
    if ([key isEqualToString:@"columns"]&&[value isKindOfClass:[NSArray class]]) {
        NSMutableArray *modelArr=[[NSMutableArray alloc] init];
        for (int i=0; i<[value count]; i++) {
            NSDictionary *dic=[value objectAtIndex:i];
            
            ColumnModel *model=[[ColumnModel alloc] initWithDictionary:dic];
            [modelArr addObject:model];
            
        }
        self.columns=modelArr;
        
    }else{
    [super setValue:value forKey:key];
    }
}

@end
