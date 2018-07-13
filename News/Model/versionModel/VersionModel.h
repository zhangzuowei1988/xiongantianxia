//
//  VersionModel.h
//  News
//
//  Created by pdmi on 2017/7/5.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigModel.h"
#import "PageModel.h"
@interface VersionModel : NSObject
@property(nonatomic,strong)NSString *version;
@property(nonatomic,strong)ConfigModel *configModel;
@property(nonatomic,strong)NSArray<PageModel *> *pages;
/**
 通过dict向model的属性赋值
 
 @param dict 属性的值
 @return 返回Model实例
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
