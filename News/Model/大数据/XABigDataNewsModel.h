//
//  XABigDataNewsModel.h
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XANewsModel.h"


@interface XABigDataNewsModel : PDMIObjectBase

@property(nonatomic,strong)NSString *ShareURL;
@property(nonatomic,strong)NSString *clickUrl;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *createTimeStr;
@property(nonatomic,strong)NSArray *filter_keywords;
@property(nonatomic,assign)BOOL is_clk;
@property(nonatomic,strong)NSString *itemId;
@property(nonatomic,strong)NSString *media;
@property(nonatomic,strong)NSString *originalUrl;
@property(nonatomic,strong)NSArray *picList;
@property(nonatomic,strong)NSString *reason;
@property(nonatomic,strong)NSString *rec_time;
@property(nonatomic,strong)NSString *req_info;
@property(nonatomic,strong)NSArray<NSDictionary*> *tags;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *shareImage;
@property(nonatomic,assign)NewsCellPicType newsCellPicType;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGFloat titleLabelHeight;

/**
 动态计算cell的高度
 */
- (void)caculateFrame;
@end
