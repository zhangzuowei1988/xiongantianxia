//
//  XANewsListViewController.m
//  News
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANewsListViewController.h"
#import "XARecommendViewController.h"
#import "XANewsRecomViewController.h"
#import "NewsAgent.h"
#import "XABigDataNewsModel.h"
#import "XAPublishNewsViewController.h"

@interface XANewsListViewController ()

@end

@implementation XANewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarHidden = YES;
    if ([self.columItem.name isEqualToString:@"雄安发布"]) { //推荐
        XAPublishNewsViewController *main=[[XAPublishNewsViewController alloc] init];
        self.columItem.columnLink = xionganPublishListUrl;
        main.columItem=self.columItem;
        main.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:main.view];
        [self addChildViewController:main];
    }else {//大数据
        XANewsRecomViewController *main=[[XANewsRecomViewController alloc]init];
        main.columItem=self.columItem;
        main.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:main.view];
        [self addChildViewController:main];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
