 //
//  H5DetailController.m
//  News
//
//  Created by pdmi on 2017/7/19.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "H5NewsDetailController.h"
#import "AppDelegate.h"
#import "Masonry.h"
#import "PDMISandboxFile.h"
#import "H5PreviewFileViewController.h"
#import "XAProgressHUD.h"
#import "Reachability.h"

@interface H5NewsDetailController ()
@property (nonatomic, assign) BOOL gk_statusBarStyle;

@end

@implementation H5NewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addContentView];
}
- (void)addContentView
{
    if ([[CommData deviceNetWorkStatus] isEqualToString:@"UNKNOWN"]) {
        [self setErrorViewWithCode:-1009];
        return;
    }
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self setWebView];
    if (self.showShareBtn==YES) {
        [self setRightShareBtn];
    }
    self.navBarTitlelabel.text = self.myTitle;

}

/**
 从新加载
 */
-(void)reLoadRequest
{
    [self addContentView];
}

-(void)backbtnPressed{
    if(self.wkWebView.canGoBack){
        [self.wkWebView goBack];
        return;
    }
    [self.wkWebView stopLoading];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    [self.wkWebView removeFromSuperview];
    self.wkWebView=nil;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setWebView{
    //创建一个WKWebView的配置对象
    WKWebViewConfiguration *configur = [[WKWebViewConfiguration alloc] init];
    //设置configur对象的preferences属性的信息
    WKPreferences *preferences = [[WKPreferences alloc] init];
    configur.preferences = preferences;
    //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
    preferences.javaScriptEnabled = YES;
    self.wkWebView=[[WKWebView alloc] init];
    self.wkWebView.scrollView.scrollIndicatorInsets = self.wkWebView.scrollView.contentInset;
     self.wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;

    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleStr]]];
    [self.view addSubview:self.wkWebView];
    
    [self.wkWebView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(self.originY);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKScriptMessageHandler

/*
 1、js调用原生的方法就会走这个方法
 2、message参数里面有2个参数我们比较有用，name和body，
 2.1 :其中name就是之前已经通过addScriptMessageHandler:name:方法注入的js名称
 2.2 :其中body就是我们传递的参数了，我在js端传入的是一个字典，所以取出来也是字典，字典里面包含原生方法名以及被点击图片的url
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
 
}
#pragma mark - WKUIDelegate(js弹框需要实现的代理方法)
//使用了WKWebView后，在JS端调用alert()是不会在HTML中显式弹出窗口，是我们需要在该方法中手动弹出iOS系统的alert的
//该方法中的message参数就是我们JS代码中alert函数里面的参数内容
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"js弹框了");
    completionHandler();
    
}

// 页面加载完调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    [self.loadingView hide];

}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    decisionHandler(WKNavigationActionPolicyAllow);
    
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%@",error);
    
}


@end
