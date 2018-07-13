//
//  H5XADetailViewController.m
//  News
//
//  Created by mac on 2018/5/28.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "H5XADetailViewController.h"
#import "PDMISandboxFile.h"
#import "H5PreviewFileViewController.h"
#import "Reachability.h"
#import "XAProgressHUD.h"
#import <UShareUI/UShareUI.h>
#import "XANewsShareManager.h"
@interface H5XADetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSArray *formatArray;
@end

@implementation H5XADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.formatArray = @[@"shtml",@"htm",@"html",@"asp"];
    [self addContentView];
}

- (void)addContentView
{
    if ([[CommData deviceNetWorkStatus] isEqualToString:@"UNKNOWN"]) {
        [self setErrorViewWithCode:-1009];
        return;
    }
    if (![CommData shareInstance].isFirstLoadWebView) {
        [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
        [CommData shareInstance].isFirstLoadWebView = YES;
    }
    [self.view addSubview:self.webView];
    self.navBarTitlelabel.text = self.myTitle;
    if (self.shareTitle.length>0) {
        [self setRightShareBtn];
    }
}
-(void)reLoadRequest
{
    [self addContentView];
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
-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.originY, ScreenWidth, self.view.height-self.originY)];
        _webView.delegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        _webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_webView];
    }
    return _webView;
}
-(void)backbtnPressed{
    if(self.webView.canGoBack){
        [self.webView goBack];
        return;
    }
    [self.webView stopLoading];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    [self.webView removeFromSuperview];
    self.webView=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
#warning 如果跳转的域名不是当前环境的域名，就跳转到Safari打开
//    if (![self.url containsString:url.host]) {
//        [self openSafariWithUrl:url];
//        return NO;
//    };
    if ((navigationType ==UIWebViewNavigationTypeLinkClicked)&&![self.formatArray containsObject:url.path.pathExtension]) {
        NSString *filePath = [PDMISandboxFile downloadFilePath:url.absoluteString];
        if (filePath) {
            if ([url.path.pathExtension isEqualToString:@"zip"]||[url.path.pathExtension isEqualToString:@"rar"]) {
                [self addActivityViewController:[PDMISandboxFile downloadFilePath:url.absoluteString]] ;
            } else {
                H5PreviewFileViewController *h5VC = [[H5PreviewFileViewController alloc]init];
                h5VC.filePath = [PDMISandboxFile downloadFilePath:url.absoluteString];
                [self.navigationController pushViewController:h5VC animated:YES];
            }
        } else {
            [self checkWifi:request.URL];
        }
        return NO;
    }
    return YES;
}

/**
 safari打开网页

 @param url 网页链接
 */
-(void)openSafariWithUrl:(NSURL*)url
{
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [[UIApplication sharedApplication] openURL:url options:@{}
                                     completionHandler:^(BOOL success) {
                                         NSLog(@"Open %d",success);
                                     }];
        } else {
            BOOL success = [[UIApplication sharedApplication] openURL:url];
            NSLog(@"Open  %d",success);
        }
        
    } else{
        bool can = [[UIApplication sharedApplication] canOpenURL:url];
        if(can){
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingView hide];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.loadingView hide];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)checkWifi:(NSURL*)url
{
    __weak typeof(self) weakSelf = self;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reachability currentReachabilityStatus]!=ReachableViaWiFi) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:IS_LOADING preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [XAProgressHUD showMBProgressHUDOnView:weakSelf.view onlyLabelText:LOADING_CURRENT AfterSecond:1.0];
            [[NewsNetWork shareInstance] downLoadFileWithUrl:url.absoluteString withComplete:^(id result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([url.path.pathExtension isEqualToString:@"zip"]||[url.pathExtension isEqualToString:@"rar"]) {
                        [weakSelf addActivityViewController:[PDMISandboxFile downloadFilePath:url.absoluteString]];
                    } else {
                        H5PreviewFileViewController *h5VC = [[H5PreviewFileViewController alloc]init];
                        h5VC.filePath = [PDMISandboxFile downloadFilePath:url.absoluteString];
                        [weakSelf.navigationController pushViewController:h5VC animated:YES];
                    }
                });
            } withErrorBlock:^(NSError *error) {
                
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    } else{
        [XAProgressHUD showMBProgressHUDOnView:weakSelf.view onlyLabelText:@"正在下载" AfterSecond:1.0];
        [[NewsNetWork shareInstance] downLoadFileWithUrl:url.absoluteString withComplete:^(id result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([url.path.pathExtension isEqualToString:@"zip"]||[url.path.pathExtension isEqualToString:@"rar"]) {
                    [weakSelf addActivityViewController:[PDMISandboxFile downloadFilePath:url.absoluteString]] ;
                } else {
                    H5PreviewFileViewController *h5VC = [[H5PreviewFileViewController alloc]init];
                    h5VC.filePath = [PDMISandboxFile downloadFilePath:url.absoluteString];
                    [weakSelf.navigationController pushViewController:h5VC animated:YES];
                }
                
            });
        } withErrorBlock:^(NSError *error) {
            
        }];
    }
}
- (void)addActivityViewController:(NSString *)path
{
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL fileURLWithPath:path]] applicationActivities:nil];
    UIPopoverPresentationController *popover = activity.popoverPresentationController;
    if (popover) {
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    [self presentViewController:activity animated:YES completion:NULL];
}
#pragma mark - 分享
- (void)showUMShareView
{
    [[XANewsShareManager defaultManager] shareNewsWithTitle:self.shareTitle newsContent:nil thumbImg:nil newsLink:_url viewController:self];
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
