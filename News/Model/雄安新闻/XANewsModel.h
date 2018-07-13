//
//  XANewsModel.h
//  News
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XANewsModel : PDMIObjectBase

@property(nonatomic,strong)NSString *id;
@property(nonatomic,assign)NSInteger contentType;
@property(nonatomic,strong)NSString *tag;
@property(nonatomic,strong)NSString *channelId;
@property(nonatomic,strong)NSString *publishTime;
@property(nonatomic,strong)NSArray *mCoverImgs;
@property(nonatomic,strong)NSArray *mCarouselImg;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *jsonLink;
@property(nonatomic,strong)NSString *sourceName;
@property(nonatomic,strong)NSString *shareImage;
@property(nonatomic,assign)NewsCellPicType newsCellPicType;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGFloat titleLabelHeight;
@property(nonatomic,assign)NSInteger numbersIndex;

/**
 动态计算cell的高度
 */
- (void)caculateFrame;
@end
