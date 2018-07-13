//
//  XAHomeListViewController.m
//  News
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAHomeListViewController.h"
#import "Masonry.h"
#import "XAGreatEventH5ViewController.h"
#import "XAAboutXiongAnViewController.h"
#import "XARecommendViewController.h"
#import "H5NewsDetailController.h"

@interface XAHomeListViewController ()

@end

@implementation XAHomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.columItem.columnStyle==0) { //推荐
        
        XARecommendViewController *main=[[XARecommendViewController alloc] init];
        main.columItem=self.columItem;
        main.columItem.columnLink = [NSString stringWithFormat:@"%@%@",baseUrl,self.columItem.columnLink];
        main.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:main.view];
        [self addChildViewController:main];
    }else if(self.columItem.columnStyle==1){//雄安大事
        XAGreatEventH5ViewController *greatEventViewController=[[XAGreatEventH5ViewController alloc] init];
        greatEventViewController.url = [NSString stringWithFormat:@"%@%@",baseUrl,self.columItem.columnLink];
        greatEventViewController.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:greatEventViewController.view];
        [self addChildViewController:greatEventViewController];
    }else if (self.columItem.columnStyle==2){//关于雄安
        XAAboutXiongAnViewController *live=[[XAAboutXiongAnViewController alloc] init];
        live.columItem=self.columItem;
        live.columItem.columnLink = [NSString stringWithFormat:@"%@%@",baseUrl,self.columItem.columnLink];
        live.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:live.view];
        [self addChildViewController:live];
        
    }else if (self.columItem.columnStyle==3){//雄安未来
        UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        topLineView.backgroundColor = UIColorFromRGB(0xe5e5e5);
        XARecommendViewController *main=[[XARecommendViewController alloc] init];
        main.columItem=self.columItem;
        main.columItem.columnLink = [NSString stringWithFormat:@"%@%@",baseUrl,self.columItem.columnLink];
        main.contentViewFrame=self.contentViewFrame;
        [self.view addSubview:main.view];
        [main.view addSubview:topLineView];
        [self addChildViewController:main];

    }
    else{
        UIViewController *controller=[[UIViewController alloc] init];
        [self.view addSubview:controller.view];
        [self addChildViewController:controller];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}
@end
