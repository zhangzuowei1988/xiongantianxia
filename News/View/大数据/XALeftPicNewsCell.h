//
//  XABigDataLeftPicNewsCell.h
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XANewsBaseCell.h"

#import "XABigDataNewsModel.h"
@interface XALeftPicNewsCell : XANewsBaseCell

@property(nonatomic,strong)XABigDataNewsModel *bigDataNewsModel;
@property(nonatomic,strong)XANewsModel *newsModel;
@property(nonatomic,strong)XAPublishNewsModel *publishNewsModel;


@end


