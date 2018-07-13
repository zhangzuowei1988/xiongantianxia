//
//  XAGreatEventH5ViewController.m
//  News
//
//  Created by mac on 2018/5/11.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAGreatEventH5ViewController.h"
#import <WebKit/WebKit.h>
#import "H5XADetailViewController.h"
@interface XAGreatEventH5ViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    WKWebView *webView;
}
@end

@implementation XAGreatEventH5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden =  YES;
    webView = [[WKWebView alloc]init];
    [self.view addSubview:webView];
    if (CGRectIsNull(self.contentViewFrame)||CGRectEqualToRect(self.contentViewFrame, CGRectZero)) {
      webView.frame = CGRectMake(0,self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY-self.tabHeight);
    }else{
        webView.frame = self.contentViewFrame;
    }
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    topLineView.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [self.view addSubview:topLineView];
    webView.top = webView.top+1;
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [webView reload];
}
#pragma mark - loadingView
-(void)setLoadingView
{
    if (!self.loadingView) {
        self.loadingView=[[JHUD alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        self.loadingView.messageLabel.text=LOADING_TITLE;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - WKNavigationDelegate
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    [self.loadingView hide];
}
//点击栏目跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        NSString *url =navigationAction.request.URL.absoluteString;
        if (url.length>0) {
            H5XADetailViewController *detail = [[H5XADetailViewController alloc]init];
            detail.url = url;
            [self.navigationController pushViewController:detail animated:YES];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);

}
@end
