//
//  H5PreviewFileViewController.m
//  News
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "H5PreviewFileViewController.h"

@interface H5PreviewFileViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation H5PreviewFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[CommData deviceNetWorkStatus] isEqualToString:@"UNKNOWN"]) {
        [self setErrorViewWithCode:-1009];
        return;
    }
    [self addWebView];
}
- (void)addWebView
{
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, self.originY, self.view.width, self.view.height-self.originY)];
    if(self.filePath.length==0){
        return;
    }
    NSURL *fileUrl = [NSURL fileURLWithPath:self.filePath];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];

    if([[UIDevice currentDevice].systemVersion floatValue] >=9.0) {
        [self.webView loadFileURL:fileUrl allowingReadAccessToURL:fileUrl];
    } else {
        NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileUrl.lastPathComponent];
    NSURL *tempUrl = [NSURL URLWithString:tempPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:tempPath]) {
        [[NSFileManager defaultManager] copyItemAtURL:fileUrl toURL:tempUrl error:nil];
    }
        [self.webView loadRequest:[NSURLRequest requestWithURL:tempUrl]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    [self.loadingView hide];

}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self.loadingView hide];

    NSLog(@"didFailProvisionalNavigation");

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
