//
//  XAGoverAffairsListViewController.m
//  News
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAGoverAffairsListViewController.h"
#import "XAGoverAffairsViewController.h"

@interface XAGoverAffairsListViewController ()

@end

@implementation XAGoverAffairsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    if (self.columItem.columnStyle==0) { //安新县
        XAGoverAffairsViewController *main=[[XAGoverAffairsViewController alloc] init];
        main.columItem=self.columItem;
        main.columItem.columnLink = [NSString stringWithFormat:@"%@%@",baseUrl,self.columItem.columnLink];
        main.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:main.view];
        [self addChildViewController:main];
    }else if (self.columItem.columnStyle==1){//容城县
        XAGoverAffairsViewController *main=[[XAGoverAffairsViewController alloc] init];
        main.columItem=self.columItem;
        main.columItem.columnLink = [NSString stringWithFormat:@"%@%@",baseUrl,self.columItem.columnLink];
        main.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:main.view];
        [self addChildViewController:main];
    }else if (self.columItem.columnStyle==2){//雄县
        XAGoverAffairsViewController *main=[[XAGoverAffairsViewController alloc] init];
        main.columItem=self.columItem;
        main.columItem.columnLink = [NSString stringWithFormat:@"%@%@",baseUrl,self.columItem.columnLink];
        main.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:main.view];
        [self addChildViewController:main];
    }
}

@end
