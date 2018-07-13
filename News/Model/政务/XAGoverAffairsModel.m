//
//  XAGoverAffairsModel.m
//  News
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAGoverAffairsModel.h"

@implementation XAGoverAffairsModel
-(void)caculateFrame
{
    CGSize labelSize = XA_MULTILINE_TEXTSIZE(self.affairsContent, [UIFont fontWithName:@"PingFangSC-Regular" size:16], CGSizeMake(ScreenWidth-32, 1000), NSLineBreakByCharWrapping);
    if (labelSize.height<30) {//显示一行
        self.cellHeight = 70;
    } else {//显示两行
        self.cellHeight = 104;
    }
    
}
@end
