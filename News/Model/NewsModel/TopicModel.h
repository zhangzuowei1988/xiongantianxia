//
//  TopicModel.h
//  News
//
//  Created by pdmi on 2017/6/12.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColumnModel.h"
@interface TopicModel : PDMIObjectBase

@property(nonatomic,strong)NSString *logofile;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSArray<ColumnModel *> *columns;
/**
 通过dict向model的属性赋值
 
 @param dict 属性的值
 @return 返回Model实例
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
