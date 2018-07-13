//
//  XABigDataNewsModel.m
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XABigDataNewsModel.h"

@implementation XABigDataNewsModel

-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"createTime"]) {
       self.createTimeStr = [NSString intervalSinceInternalNow:[NSString bigDataTimestampWithString:oldValue]];
    } else if ([property.name isEqualToString:@"picList"]) {
        NSArray *picArray = (NSArray*)oldValue;
        if (picArray.count==0) {
            self.newsCellPicType = NewsCellPicTypeNone;
        } else if (picArray.count<3) {
            self.shareImage = picArray.firstObject;
            self.newsCellPicType = NewsCellPicTypeLeft;
        } else if (picArray.count>=3) {
            self.shareImage = picArray.firstObject;
            self.newsCellPicType = NewsCellPicTypeThree;
        }
    }
    return oldValue;
}

-(void)caculateFrame
{
    switch (self.newsCellPicType) {
        case NewsCellPicTypeLeft:
            self.cellHeight = 100;
            break;
        case NewsCellPicTypeTop:
        {
            CGFloat imageHeight = (ScreenWidth-30)*3/4;
            CGSize labelSize = XA_MULTILINE_TEXTSIZE(self.title, [UIFont systemFontOfSize:16], CGSizeMake(ScreenWidth-30, 1000), NSLineBreakByCharWrapping);
            if (labelSize.height<30) {//显示一行
                self.titleLabelHeight = 22;
                self.cellHeight = imageHeight+65+22;
            } else {//显示两行
                self.titleLabelHeight = 45;
                self.cellHeight = imageHeight+65+45;
            }
        }

            break;
        case NewsCellPicTypeNone:
        {
            CGSize labelSize = XA_MULTILINE_TEXTSIZE(self.title,[UIFont fontWithName:@"PingFangSC-Regular" size:16], CGSizeMake(ScreenWidth-30, 1000), NSLineBreakByCharWrapping);
            if (labelSize.height<30) {//显示一行
                self.titleLabelHeight = 22;
                self.cellHeight = 72;

            } else {//显示两行
                self.titleLabelHeight = 45;
                self.cellHeight = 95;

            }
        }
            break;
        case NewsCellPicTypeThree:
        {
            CGFloat imageWidth = (ScreenWidth-40)/3;
            CGFloat imageHeight = imageWidth*3/4;
            CGSize labelSize = XA_MULTILINE_TEXTSIZE(self.title, [UIFont systemFontOfSize:16], CGSizeMake(ScreenWidth-30, 1000), NSLineBreakByCharWrapping);
            if (labelSize.height<30) {//显示一行
                self.titleLabelHeight = 22;
                self.cellHeight = imageHeight+65+22;
            } else {//显示两行
                self.titleLabelHeight = 45;
                self.cellHeight = imageHeight+65+45;
            }
        }
            break;

        default:
            break;
    }
}

@end
