//
//  XAPublishNewsModel.h
//  News
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "PDMIObjectBase.h"
#import "XANewsModel.h"
@interface XAPublishNewsModel : PDMIObjectBase
@property(nonatomic,strong)NSString *articleLink;
@property(nonatomic,strong)NSString *publishTime;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *shareImage;
@property(nonatomic,strong)NSArray  *imageUrls;
@property(nonatomic,assign)NewsCellPicType newsCellPicType;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGFloat titleLabelHeight;
@property(nonatomic,assign)NSInteger numbersIndex;

/**
 动态计算cell的高度
 */
- (void)caculateFrame;

@end
