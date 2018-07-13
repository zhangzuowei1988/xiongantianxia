//
//  XAPersonSettingCell.h
//  News
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XAPersonSettingCell : BaseTableCell
@property(nonatomic,strong)UILabel *itemTitleLabel;
@property(nonatomic,strong)UITextField *itemSubTitleTextField;
@property(nonatomic,strong)UIImageView *itemImageView;
@property(nonatomic,strong)UIView *bottomLine;

@end
