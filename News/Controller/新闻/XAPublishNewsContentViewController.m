//
//  XAPublishNewsContentViewController.m
//  News
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAPublishNewsContentViewController.h"
#import <WebKit/WebKit.h>
#import "H5XADetailViewController.h"
#import <UShareUI/UShareUI.h>
#import "XANewsShareManager.h"
@interface XAPublishNewsContentViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)UIScrollView *newsScrollView;
@property(nonatomic,strong)UILabel *titlelabel;//新闻标题
@property(nonatomic,strong)UILabel *dateLabel;//新闻事件
@property(nonatomic,strong)UILabel *editLabel;//编辑
@property(nonatomic,strong)WKWebView *webView;//加载新闻页
@property(nonatomic,strong)NSString *newsSumary;//新闻概要
@property(nonatomic,strong)NSString *shareImage;//分享图片
@property(nonatomic,strong)NSString *shareLink;//分享链接

@property(nonatomic,assign)BOOL isFinish;

@end

@implementation XAPublishNewsContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addContentView];
    [self setRightShareBtn];

    _isFinish = YES;
    self.uri = [NSString stringWithFormat:@"%@%@",xionganPublishUrl,_uri];
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}

/**
 添加分享按钮，如果手机没有安装微信和QQ就不显示分享微信和QQ按钮
 */
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _isFinish = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_isFinish) {
        [_webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
        [_webView loadHTMLString:@"" baseURL:nil];
        [_webView removeFromSuperview];
        _webView=nil;
    }
}

/**
 初始化主界面
 */
- (void)addContentView
{
    [self.view addSubview:self.newsScrollView];
    [self.newsScrollView addSubview:self.titlelabel];
    [self.newsScrollView addSubview:self.webView];
    [self.newsScrollView addSubview:self.editLabel];
    [self.newsScrollView addSubview:self.dateLabel];
}

/**
 编辑
 */
-(UILabel *)editLabel
{
    if (_editLabel == nil) {
        _editLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.newsScrollView.height-10, ScreenWidth-15,22)];
        _editLabel.backgroundColor = [UIColor whiteColor];
        _editLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        _editLabel.textColor = [UIColor blackColor];
    }
    return _editLabel;
}
-(UIScrollView *)newsScrollView
{
    if (_newsScrollView==nil) {
        _newsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.originY, ScreenWidth, self.view.height-self.originY)];
        _newsScrollView.contentSize = CGSizeMake(ScreenWidth, self.view.height-self.originY);
    }
    return _newsScrollView;
}
-(WKWebView *)webView
{
    if (_webView==nil) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 100)];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
//        _webView.userInteractionEnabled = NO;
        [_webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}
//日期
-(UILabel *)dateLabel
{
    if (_dateLabel==nil) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,22)];
        _dateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _dateLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
        _dateLabel.numberOfLines = 1;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}
-(UILabel *)titlelabel
{
    if (_titlelabel==nil) {
        _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, ScreenWidth-30,0)];
        _titlelabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:26];
        _titlelabel.textColor = [UIColor blackColor];
        _titlelabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titlelabel.numberOfLines = 0;
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel;
}
#pragma mark - loadingView
-(void)setLoadingView
{
    if (!self.loadingView) {
        self.loadingView=[[JHUD alloc] initWithFrame:CGRectMake(0, self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        self.loadingView.messageLabel.text=LOADING_TITLE;
    }
}

#pragma mark - 重新加载
- (void)reLoadRequest
{
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}
#pragma mark - 刷新
-(void)refresh{
    if (self.errorView!=nil) {
        [self.errorView setHidden:YES];
    }
    __weak __typeof(self)weakSelf = self;
    [[NewsNetWork shareInstance] getMainListWithLink:self.uri WithComplete:^(id result) {
        [self.loadingView hide];
        if (result==nil) {
            [weakSelf setErrorViewWithCode:0];
        } else
        [weakSelf resetNewsModelWithDict:result[@"data"]];
        
    } withErrorBlock:^(NSError *error) {
            [weakSelf setErrorViewWithCode:error.code];
            [weakSelf.loadingView hide];
        
    }];
}

/**
 处理网络下载完的数据

 */
- (void)resetNewsModelWithDict:(NSDictionary*)result
{
//    NSLog(@"%@",result);
    NSDictionary *articleDic = result[@"article"];
    NSString *dateStr = checkNull(articleDic[@"publishTime"]);
    NSString *sourceStr = checkNull(articleDic[@"source"]);
    NSString *editorStr = checkNull(articleDic[@"editor"]);
    NSString *author = checkNull(articleDic[@"author"]);
    self.titlelabel.text =checkNull(articleDic[@"title"]);
    _newsSumary = checkNull(articleDic[@"summary"]);
    _shareImage = checkNull(articleDic[@"shareImage"]);
    _shareLink = checkNull(articleDic[@"shareLink"]);

    self.dateLabel.text = [NSString stringWithFormat:@"%@  %@  %@",dateStr,sourceStr,author];
    if (editorStr.length>0) {
        self.editLabel.text = [NSString stringWithFormat:@"责任编辑：%@",editorStr];
    } else {
        self.editLabel.hidden=NO;
    }
    NSString *path = [[NSBundle mainBundle]pathForResource:@"article" ofType:@"html"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *xml =checkNull(articleDic[@"body"][@"newstext"]);
    str = [str stringByReplacingOccurrencesOfString:@"mainnews" withString:xml];
    [self.webView loadHTMLString:str baseURL:nil];
    CGSize labelSize = XA_MULTILINE_TEXTSIZE(self.titlelabel.text, [UIFont fontWithName:@"PingFangSC-Medium" size:24], CGSizeMake(ScreenWidth-30, 1000), NSLineBreakByCharWrapping);

    self.titlelabel.height = labelSize.height+20;
    self.dateLabel.top = self.titlelabel.bottom;
    self.webView.top = self.dateLabel.bottom+10;
    
}
#pragma mark -WKNavigationDelegate

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        NSString *url = navigationAction.request.URL.absoluteString;
        if (url.length>0) {
            H5XADetailViewController *detail = [[H5XADetailViewController alloc]init];
            detail.url = url;
            [self.navigationController pushViewController:detail animated:YES];
            _isFinish = NO;
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/**
 监听webview的高度

 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGSize contentSize = [change[@"new"] CGSizeValue];
    self.webView.size = CGSizeMake(ScreenWidth-20, contentSize.height);
    self.editLabel.top = self.webView.bottom-10;
    self.newsScrollView.contentSize = CGSizeMake(self.newsScrollView.width, self.editLabel.bottom+10);
}
#pragma mark - 分享
- (void)showUMShareView
{
    [[XANewsShareManager defaultManager] shareNewsWithTitle:self.titlelabel.text newsContent:_newsSumary thumbImg:_shareImage newsLink:_shareLink viewController:self];
}
@end
