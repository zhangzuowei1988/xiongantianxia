//
//  ZJTagItem.m
//  ZJTagView
//
//  Created by ZeroJ on 16/10/24.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "PDMITagItem.h"

@implementation PDMITagItem

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
       // self.width=60;
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
    if ([key isEqualToString:@"name"]) {
         CGSize size =[value sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[CommData shareInstance].scale*SecondTitleFontSize]}];
        self.width=size.width+23;
        self.columnTitle = [NSString stringWithFormat:@"%@",value];
    } else if ([key isEqualToString:@"link"]) {
        self.columnLink = [NSString stringWithFormat:@"%@",value];
    } else if ([key isEqualToString:@"id"]) {
        self.columnId = [NSString stringWithFormat:@"%@",value];
    }
    
    [super setValue:value forKey:key];
}


@end
