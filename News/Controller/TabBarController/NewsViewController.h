//
//  NewsViewController.h
//  News
//
//  Created by pdmi on 2017/4/27.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DLCustomSlideView.h"
@interface NewsViewController : BaseViewController<DLCustomSlideViewDelegate>
@property (strong, nonatomic)  DLCustomSlideView *slideView;


@end;
