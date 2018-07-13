//
//  PageModel.h
//  News
//
//  Created by pdmi on 2017/7/5.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDMITagItem.h"
@interface PageModel : NSObject

@property(nonatomic,strong)NSString *tabId;
@property(nonatomic,strong)NSString *pageStyle;
@property(nonatomic,strong)NSString *columnNavType;
@property(nonatomic)NSInteger navigationStyle;
@property(nonatomic,strong)NSString *tabTitle;
@property(nonatomic,strong)NSString *tabImage;
@property(nonatomic,strong)NSString *selectImage;
@property(nonatomic)BOOL search;
@property(nonatomic,strong)NSString *tabLink;
@property(nonatomic,strong)NSMutableArray<PDMITagItem*>*columnList;
/**
 通过dict向model的属性赋值
 
 @param dict 属性的值
 @return 返回Model实例
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
