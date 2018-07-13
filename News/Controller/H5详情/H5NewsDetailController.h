//
//  H5DetailController.h
//  News
//
//  Created by pdmi on 2017/7/19.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <WebKit/WebKit.h>
#import "NewsContentBaseController.h"
@interface H5NewsDetailController : NewsContentBaseController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)NSString *articleStr;
@property(nonatomic,copy)NSString *myTitle;

@property (nonatomic, strong) WKWebView *wkWebView;
@property(nonatomic)BOOL showShareBtn;
@property(nonatomic)BOOL showMoreBtn;
@end
