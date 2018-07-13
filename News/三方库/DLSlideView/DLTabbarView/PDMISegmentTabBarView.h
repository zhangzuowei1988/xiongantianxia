//
//  PDMISegmentTabBarView.h
//  News
//
//  Created by pdmi on 2017/7/5.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSlideTabbarProtocol.h"
#import "PDMITagItem.h"


@interface PDMISegmentTabBarView : UIView<DLSlideTabbarProtocol>
/**
 选中label的背景颜色（默认灰色）
 */
@property (nonatomic, strong) UIColor *selectedViewColor;
/**
 未选中label的颜色（默认黑色）
 */

// borderColor
@property(nonatomic,strong)UIColor *borderColor;
//选中的字体颜色
@property(nonatomic,strong)UIColor *selectTextColor;

@property (nonatomic, strong) UIColor *normalLabelColor;
/**
 数据源
 */
@property (nonatomic, strong) NSArray *tabbarItems;


@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, weak) id<DLSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;

@end
