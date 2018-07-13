//
//  XANonePicNewsCell.h
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANewsBaseCell.h"

@interface XANonePicNewsCell : XANewsBaseCell

@property(nonatomic,strong)XABigDataNewsModel *bigDataNewsModel;
@property(nonatomic,strong)XANewsModel *newsModel;
@property(nonatomic,strong)XAPublishNewsModel *publishNewsModel;

@end
