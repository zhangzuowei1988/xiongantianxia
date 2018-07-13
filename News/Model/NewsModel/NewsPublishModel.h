//
//  NewsPublishModel.h
//  News
//
//  Created by pdmi on 2017/7/4.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsPublishModel : PDMIObjectBase

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *publishId;
@property(nonatomic,strong)NSString *confirm;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *link;

/**
 通过dict向model的属性赋值

 @param dict 属性的值
 @return 返回Model实例
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
