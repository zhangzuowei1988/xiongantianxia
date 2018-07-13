//
//  ZJTagView.h
//  ZJTagView
//
//  Created by ZeroJ on 16/9/27.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDMITagItem.h"

@class PDMITagView;
@protocol PDMITagViewDelegate <NSObject>

/**
 在编辑状态下 栏目的改变

 @param tagView 栏目选择板
 @param inEditState 是否在编辑状态
 */
- (void)tagView:(PDMITagView *)tagView didChangeInEditState:(BOOL)inEditState;

/**
 在不是编辑状态下栏目tag改变

 @param tagView 栏目选择板
 @param index 选中栏目的index
 */
- (void)tagView:(PDMITagView *)tagView didSelectTagWhenNotInEditState:(NSInteger)index;

/**
 删除按钮被点击
 */
- (void)tagViewDidClickDeleteButton;


@end

@interface PDMITagView : UIView

/**
 初始化选择面板

 @param selectedItems 选中栏目
 @param unselectedItems 未选中的栏目
 @return 返回PDMITagView实例
 */
- (instancetype)initWithSelectedItems:(NSMutableArray<PDMITagItem *> *)selectedItems unselectedItems:(NSMutableArray<PDMITagItem *> *)unselectedItems;

@property (strong, nonatomic) NSString *unselctedSectionTitle;

@property (assign, nonatomic) BOOL inEditState;

@property (weak, nonatomic) id<PDMITagViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray<PDMITagItem *> *selectedItems;
@property (strong, nonatomic) NSMutableArray<PDMITagItem *> *unselectedItems;
@end
