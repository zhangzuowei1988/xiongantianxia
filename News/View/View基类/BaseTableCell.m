//
//  BaseTableCell.m
//  News
//
//  Created by pdmi on 2017/8/2.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
        [self setCellStyle];
        
    }
    return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
        [self setCellStyle];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setSelectionStyle: UITableViewCellSelectionStyleNone];
    [self setCellStyle];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
@end
