//
//  XACyclePicView.m
//  News
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XACyclePicView.h"
#import "XANewsModel.h"
#import "XAPublishNewsModel.h"
@implementation XACyclePicView

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
    self.cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:self.bounds];
    self.cycleScrollView.delegate=self;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.pageControlDotSize = CGSizeMake(4, 4);
    self.cycleScrollView.titleLabelTextFont=[UIFont fontWithName:@"PingFangSC-Regular" size:ThirdTitleFontSize*[CommData shareInstance].scale];
    self.cycleScrollView.titleLabelTextColor=[UIColor whiteColor];
    self.cycleScrollView.titleLabelHeight = 27;
    self.cycleScrollView.titleLabelTextAlignment=NSTextAlignmentLeft;
    [self addSubview:self.cycleScrollView];
}
//普通轮播图数据绑定
- (void)setCycleDataArray:(NSArray *)cycleDataArray
{
    _cycleDataArray = cycleDataArray;
    if (_cycleDataArray) {
        NSMutableArray *imageArr=[[NSMutableArray alloc]init];
        NSMutableArray *titleArr=[[NSMutableArray alloc]init];
        for (int i=0; i<[_cycleDataArray count]; i++) {
            XANewsModel *listModel=[_cycleDataArray objectAtIndex:i];
            NSString *imgUrl=[listModel.mCarouselImg count]>0? [listModel.mCarouselImg objectAtIndex:0]: @"placeholder_image";
            [imageArr addObject: imgUrl];
            [titleArr addObject:listModel.title];
        }
        self.cycleScrollView.imageURLStringsGroup=imageArr;
        self.cycleScrollView.titlesGroup=titleArr;
    }
}
//雄安发布数据绑定
-(void)setXaPublishCycleDataArray:(NSArray *)xaPublishCycleDataArray
{
    _xaPublishCycleDataArray = xaPublishCycleDataArray;
    if (_xaPublishCycleDataArray) {
        NSMutableArray *imageArr=[[NSMutableArray alloc]init];
        NSMutableArray *titleArr=[[NSMutableArray alloc]init];
        for (int i=0; i<[_xaPublishCycleDataArray count]; i++) {
            XAPublishNewsModel *listModel=[_xaPublishCycleDataArray objectAtIndex:i];
            NSString *imgUrl=[listModel.imageUrls count]>0? [listModel.imageUrls objectAtIndex:0]: @"placeholder_image";
            [imageArr addObject: imgUrl];
            [titleArr addObject:listModel.title];
        }
        self.cycleScrollView.imageURLStringsGroup=imageArr;
        self.cycleScrollView.titlesGroup=titleArr;
    }
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(XACyclePicViewDidSelectAtIndex:)]) {
        [self.delegate XACyclePicViewDidSelectAtIndex:index];
    }
}

@end
