//
//  XAAffairsCollectionCell.m
//  News
//
//  Created by mac on 2018/5/7.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAAffairsCollectionCell.h"

@interface XAAffairsCollectionCell ()
{
    UIImageView *itemImageView;
    UILabel *titleLabel;
}
@end

@implementation XAAffairsCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView
{
    itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 48, 48)];
//    itemImageView.backgroundColor = UIColorFromRGB(0xf5f5f5) ;
    [self addSubview:itemImageView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 58, 48, 17);
    titleLabel.text = @"设立变更";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    [self addSubview:titleLabel];
}
- (void)setAffairsModel:(XAAffairsModel *)affairsModel
{
    _affairsModel = affairsModel;
    if (_affairsModel) {
        [itemImageView sd_setImageWithURL:[NSURL URLWithString:_affairsModel.thumb] placeholderImage:[[CommData shareInstance] getPlaceHoldImage:itemImageView.size]];
        titleLabel.text = _affairsModel.name;
    }
    
}
@end
