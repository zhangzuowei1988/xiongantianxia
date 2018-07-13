//
//  DLSlideTabbarProtocol.h
//  DLSlideController
//
//  Created by Dongle Su on 14-12-8.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DLSlideTabbarDelegate <NSObject>
- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index;
- (void)showOrHiddenAddChannelsCollectionView:(UIButton *)button;
-(void)editBtnPressed;
-(void)editCompletedPressed;
@end

@protocol DLSlideTabbarProtocol <NSObject>
@property (nonatomic, strong) NSArray *tabbarItems;
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<DLSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;

@end
