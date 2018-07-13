//
//  XAAffairsHeadView.m
//  News
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAAffairsHeadView.h"

@implementation XAAffairsHeadView

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
    self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1/1.0];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(18, 0, 100, 32);
    self.titleLabel.text = @"企业办事";
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    self.titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    [self addSubview:self.titleLabel];
}
@end
