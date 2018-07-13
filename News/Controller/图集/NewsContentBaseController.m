//
//  NewsContentBaseController.m
//  News
//
//  Created by pdmi on 2017/10/25.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "NewsContentBaseController.h"
#import "NSString+StringRegular.h"
#import "XANewsShareManager.h"

//#import "NSString+Emoji.h"
@interface NewsContentBaseController ()<UMSocialShareMenuViewDelegate>

@end

@implementation NewsContentBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpForDismissKeyboard];
}
-(void)setRightShareBtn{
    
    NSInteger shareNum=1;
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession  ]==YES&&[[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_WechatSession ]) {
        shareNum++;
    }
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ ]==YES&&[[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_QQ]) {
        shareNum++;
    }
    if (shareNum>0) {
       self.navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-45, self.statusBarHeight + 8, 40, 28)];
        [self.navBarView addSubview:self.navRightBtn];
        [self.navRightBtn setImage:[UIImage imageNamed:@"common_top_share"] forState:UIControlStateNormal];
        [self.navRightBtn addTarget:self action:@selector(showUMShareView) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)showUMShareView
{
    if(_bigDataNewsModel){
        [[XANewsShareManager defaultManager] shareNewsWithTitle:self.bigDataNewsModel.title newsContent:nil thumbImg:self.bigDataNewsModel.shareImage newsLink:self.bigDataNewsModel.ShareURL viewController:self];
    } else {
    [[XANewsShareManager defaultManager] shareNewsWithTitle:self.newsModel.title newsContent:self.newsModel.summary thumbImg:self.newsModel.shareImage newsLink:self.newsModel.url viewController:self];
    }
}
//设置点击任何其他位置 键盘回收
-(void)setUpForDismissKeyboard{

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.view endEditing:YES];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

