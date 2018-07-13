//
//  ConfigModel.h
//  News
//
//  Created by pdmi on 2017/7/5.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigModel : NSObject

@property(nonatomic,strong)NSString *appStructure;
@property(nonatomic,strong)UIColor *skinColor;
@property(nonatomic,strong)UIColor *tabBackgroundColor;
@property(nonatomic,strong)UIColor *tabTitleColor;
@property(nonatomic,strong)UIColor *tabTitleSelectColor;
@property(nonatomic,strong)UIColor *columnBackgroundColor;
@property(nonatomic,strong)UIColor *columnTitleColor;
@property(nonatomic,strong)UIColor *columnTitleSelectColor;
/**
 通过dict向model的属性赋值
 
 @param dict 属性的值
 @return 返回Model实例
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
