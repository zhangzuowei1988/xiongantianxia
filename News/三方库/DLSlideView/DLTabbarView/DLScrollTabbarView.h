//
//  DLScrollTabbarView.h
//  DLSlideViewDemo
//
//  Created by Dongle Su on 15-2-12.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSlideTabbarProtocol.h"
#import "PDMITagItem.h"


//@interface DLScrollTabbarItem : NSObject
//@property(nonatomic, strong) NSString *title;
//@property(nonatomic,strong) NSString *columnId;
//@property(nonatomic, assign) CGFloat width;
//+ (DLScrollTabbarItem *)itemWithTitle:(NSString *)title width:(CGFloat)width columnId:(NSString *)columnId;
//@end

//@protocol DLScrollTabbarViewDelegate
//
//-(void)editColumn;
//
//@end

@interface DLScrollTabbarView : UIView<DLSlideTabbarProtocol>
@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic,strong)   UIScrollView *scrollView_;
//@property(nonatomic,weak)id<DLScrollTabbarViewDelegate>tabBarViewdelegate;
// tabbar属性
@property (nonatomic, strong) UIColor *tabItemNormalColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *tabItemSelectedColor UI_APPEARANCE_SELECTOR;
@property(nonatomic,assign)CGFloat tabItemSelectedFontSize;
@property (nonatomic, assign) CGFloat tabItemNormalFontSize;
@property(nonatomic, strong) UIColor *trackColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) NSArray *tabbarItems;
//是否有+号按钮
@property(nonatomic)BOOL showAddBtn;
//编辑按钮
@property(nonatomic,strong)UIButton *editBtn;
//加号按钮
@property(nonatomic,strong)UIButton *addChannelButton;

// DLSlideTabbarProtocol
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<DLSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;
- (void)clickAddButton:(UIButton *)button;
@end
