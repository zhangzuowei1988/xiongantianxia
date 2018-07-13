//
//  XACyclePicView.h
//  News
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"


@protocol XACyclePicViewDelegate <NSObject>

- (void)XACyclePicViewDidSelectAtIndex:(NSInteger)index;

@end

@interface XACyclePicView : BaseView<SDCycleScrollViewDelegate>
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)NSArray *cycleDataArray;
@property(nonatomic,strong)NSArray *xaPublishCycleDataArray;
@property(nonatomic,assign)id <XACyclePicViewDelegate> delegate;
@end
