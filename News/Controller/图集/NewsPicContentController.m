//
//  NewsPicContentController.m
//  News
//
//  Created by pdmi on 2017/5/27.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "NewsPicContentController.h"
#import "ContentPicView.h"
#import "XAPicListModel.h"
#import "XANewsShareManager.h"
@interface NewsPicContentController ()

@property(nonatomic,strong)NSDictionary *articleDic;
@property(nonatomic,strong)ContentPicView *picView;
@end

@implementation NewsPicContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarHidden=YES;
   
   self.picView=[[ContentPicView alloc] initWithFrame:CGRectMake(0, self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
    
    [self.view addSubview:self.picView];
     [self setNavBackBtn];
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    __weak __typeof(self)weakSelf = self;
    [[NewsNetWork shareInstance] getArticleContentWithLink:self.newsModel.jsonLink WithComplete:^(id result) {
        [self.loadingView hide];
        NSArray *picArray =[result objectForKey:@"sourceImas"];
        NSMutableArray *picModelArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in picArray) {
            XAPicListModel *model  = [[XAPicListModel alloc]init];
            model.pDescription = dict[@"description"];
            model.imgPath = dict[@"imgPath"];
            model.title = dict[@"title"];
            [picModelArray addObject:model];
        }
        if (picModelArray.count>0) {
            weakSelf.picView.picModelArrays=picModelArray;
        }
    } withErrorBlock:^(NSError *error) {
        [self.loadingView hide];
    }];
}

- (void)setShareButton
{
        NSInteger shareNum=0;
        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession  ]==YES&&[[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_WechatSession ]) {
            shareNum++;
        }
        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ ]==YES&&[[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_QQ]) {
            shareNum++;
        }
        if (shareNum>0) {
            self.navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-45, self.statusBarHeight + 8, 40, 28)];
            [self.view addSubview:self.navRightBtn];
            [self.navRightBtn setImage:[UIImage imageNamed:@"common_top_share"] forState:UIControlStateNormal];
            [self.navRightBtn addTarget:self action:@selector(showShareView) forControlEvents:UIControlEventTouchUpInside];
        }
}

/**
 调用分享
 */
- (void)showShareView
{
   [[XANewsShareManager defaultManager] shareNewsWithTitle:self.newsModel.title newsContent:nil thumbImg:self.newsModel.shareImage newsLink:self.newsModel.url viewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - commentToolBarDelegate
-(void)CommentBtnPressedWithTag:(NSInteger)tag{
    
}

@end
