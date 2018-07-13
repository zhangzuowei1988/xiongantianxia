//
//  XAGreatEventModel.h
//  News
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "PDMIObjectBase.h"

@interface XAGreatEventModel : PDMIObjectBase
@property(nonatomic,strong)NSString *eventTime;
@property(nonatomic,strong)NSString *eventContent;
@property(nonatomic,strong)NSArray *eventImages;
@property(nonatomic,assign)BOOL isFirst;
@property(nonatomic,assign)CGFloat contentLabelHeight;//计算新闻内容的高度
@property(nonatomic,assign)CGFloat cellHeight;//计算cell的高度
@property(nonatomic,assign)CGFloat imageWidth;//图片的宽
@property(nonatomic,assign)CGFloat imageHeight;//图片的高

/**
 动态计算label和cell的高度
 */
-(void)caculateLabelAndCellHeight;
@end
