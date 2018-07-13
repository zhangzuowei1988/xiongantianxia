//
//  ZJTagItem.h
//  ZJTagView
//
//  Created by ZeroJ on 16/10/24.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDMIObjectBase.h"
@interface PDMITagItem : PDMIObjectBase

@property (strong, nonatomic) NSString *columnTitle;
@property(strong,nonatomic)NSString *columnId;
@property(strong,nonatomic)NSString *columnLink;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *link;
@property(strong,nonatomic)NSString *id;
@property(strong,nonatomic)NSString *adspot;

@property(nonatomic)NSInteger columnStyle;
@property(nonatomic, assign) CGFloat width;

/**
 通过dict向model的属性赋值
 
 @param dict 属性的值
 @return 返回Model实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
