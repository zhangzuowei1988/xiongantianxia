//
//  BaseCollectionCell.h
//  News
//
//  Created by pdmi on 2017/8/2.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionCell : UICollectionViewCell
/**
 设置cell的风格
 */
-(void)setCellStyle;
/**
 注册cell里的通知
 */

-(void)registCellStyleNotification;
/**
 销毁cell里的通知
 */

-(void)destoryCellStyleNotification;
@end
