//
//  NewsContentBaseController.h
//  News
//
//  Created by pdmi on 2017/10/25.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "XANewsModel.h"
#import "XABigDataNewsModel.h"
#import <UShareUI/UShareUI.h>
@interface NewsContentBaseController : BaseViewController


@property(nonatomic,strong)XANewsModel *newsModel;
@property(nonatomic,strong)XABigDataNewsModel *bigDataNewsModel;//大数据



/**
 设置分享按钮
 */
-(void)setRightShareBtn;

//分享
//-(void)shareWithType:(NSNumber *)platformType;

/**
 显示分享面板
 */
-(void)showUMShareView;


/**
 设置model

 @param modelDic 需要设置的属性
 */
-(void)resetModelWithDic:(NSDictionary *)modelDic;

@end
