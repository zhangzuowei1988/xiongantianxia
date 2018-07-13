//
//  XAGreatEventModel.m
//  News
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAGreatEventModel.h"
#import <UIKit/UIKit.h>
#define labelMargin 71
#define cellMargin 52
@implementation XAGreatEventModel

-(void)caculateLabelAndCellHeight
{
    CGSize labelSize = XA_MULTILINE_TEXTSIZE(self.eventContent, [UIFont systemFontOfSize:16], CGSizeMake(ScreenWidth-71, 1000), NSLineBreakByCharWrapping);
    self.contentLabelHeight = labelSize.height+16;
    
    CGFloat imageWidth = 112;
    CGFloat imageHeight = 70;
    
    if (self.eventImages.count>=3) {
        //如果图片多余三张，图片大小自适应
        imageWidth = (ScreenWidth-81)/3;
        imageHeight = imageWidth*70/112;
    }
    
    if (self.eventImages.count>0) {
        self.cellHeight = cellMargin+self.contentLabelHeight+imageHeight;
    }else {
        self.cellHeight = cellMargin+self.contentLabelHeight;
    }
    self.imageWidth = imageWidth;
    self.imageHeight = imageHeight;
}

@end
