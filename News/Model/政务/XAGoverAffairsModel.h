//
//  XAGoverAffairsModel.h
//  News
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "PDMIObjectBase.h"

@interface XAGoverAffairsModel : PDMIObjectBase

@property(nonatomic,strong)NSString *affairsContent;
@property(nonatomic,strong)NSString *affairsTime;
@property(nonatomic,strong)NSString *affairsSource;
@property(nonatomic,strong)NSString *affairsUrl;
@property(nonatomic,strong)NSString *affairsTitle;
@property(nonatomic,assign)CGFloat   cellHeight;

/**
 动态计算cell的高度
 */
- (void)caculateFrame;

@end
