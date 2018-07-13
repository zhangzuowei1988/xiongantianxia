//
//  XANewsBaseCell.h
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XABigDataNewsModel.h"
#import "XANewsModel.h"
#import "XAPublishNewsModel.h"

@interface XANewsBaseCell : BaseTableCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UILabel *releaseFromLabel;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)UILabel *specialSubjectLabel;//专题

/**
 添加主界面
 */
- (void)addContentView;

@end
