//
//  NewsViewController.m
//  News
//
//  Created by pdmi on 2017/4/27.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "NewsViewController.h"
#import "DLScrollTabbarView.h"
#import "DLLRUCache.h"
#import "PDMITagView.h"
#import "BaseViewController.h"
#import "XAHomeViewController.h"
#import "XANewsMainViewController.h"
#import "XAGoverAffairsMainViewController.h"
#import "XAServiceViewController.h"
#define colummViewHeight 44

@interface NewsViewController ()<PDMITagViewDelegate>{
    NSMutableArray *itemArray_;
}
@property(nonatomic,strong) NSMutableArray *selectColumnArr;
@property(nonatomic,strong)NSMutableArray *unSelectColumnArr;
@property (strong, nonatomic) PDMITagView *tagView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.pageModel.navigationStyle==0) {
         self.navBarHidden=YES;
    }else{
        self.navBarHidden=NO;
        
        switch ([self.pageModel.pageStyle integerValue]) {
            case 0: //雄安首页
            {
                XAHomeViewController  *HomeViewController=[[XAHomeViewController alloc] init];
                HomeViewController.pageModel=self.pageModel;
                [self.view addSubview:HomeViewController.view];
                [self addChildViewController:HomeViewController];
            }
                break;
            case 1://新闻
            {
                XANewsMainViewController *newsMainViewController=[[XANewsMainViewController alloc] init];
                newsMainViewController.pageModel=self.pageModel;
                [self.view addSubview:newsMainViewController.view];
                [self addChildViewController:newsMainViewController];
            }
                break;
            case 2:// 政务
            {
                XAGoverAffairsMainViewController *newsMainViewController=[[XAGoverAffairsMainViewController alloc] init];
                newsMainViewController.pageModel=self.pageModel;
                [self.view addSubview:newsMainViewController.view];
                [self addChildViewController:newsMainViewController];
            }
                break;
            case 3: //办事
            {
                XAServiceViewController *newsMainViewController=[[XAServiceViewController alloc] init];
                newsMainViewController.pageModel=self.pageModel;
                [self.view addSubview:newsMainViewController.view];
                [self addChildViewController:newsMainViewController];
            }
                break;
            default:
                break;
        }
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
}



@end
