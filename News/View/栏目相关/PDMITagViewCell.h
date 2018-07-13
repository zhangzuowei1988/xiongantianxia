//
//  ZJTagViewCell.h
//  ZJTagView
//
//  Created by ZeroJ on 16/10/24.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDMITagViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (assign, nonatomic) BOOL inEditState;
@property (nonatomic, strong) UIButton *delButton;

@end
