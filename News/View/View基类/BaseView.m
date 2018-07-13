//
//  BaseView.m
//  News
//
//  Created by pdmi on 2017/8/2.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self setCellStyle];
    }
    return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
       [self setCellStyle];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setCellStyle];
   
}
-(void)registCellStyleNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setCellStyle)
                                                 name:SwithSunAndNightNotification
                                               object:nil];
    
}
-(void)destoryCellStyleNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SwithSunAndNightNotification object:nil];
}
-(void)setCellStyle
{
      self.backgroundColor=[CommData shareInstance].commonBottomViewColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
