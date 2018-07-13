//
//  BaseViewController.m
//  News
//
//  Created by pdmi on 2017/5/2.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "BaseViewController.h"
#import "ColumnModel.h"
#import "XAPersonCenterViewController.h"
#import "Masonry.h"
#import <UShareUI/UShareUI.h>

#import "XANewsSearchViewController.h"

#define margin 12
@interface BaseViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong)UILabel *searchFieldLabel;
@property(nonatomic,strong)UIImageView *errorImageView;
@property(nonatomic,strong)UIButton *errorBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *clickLabel;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (iPhoneX) {
        self.originY=84;
        self.tabHeight=49+34;
        self.statusBarHeight=40;
    }else{
        self.originY=64;
        self.tabHeight=49;
        self.statusBarHeight=20;
    }
    
    
    self.view.backgroundColor=[CommData shareInstance].commonBottomViewColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden=YES;
    
    [self setNavBar];
    
    
    [self setLoadingView];
    // Do any additional setup after loading the view.
}

-(void)addlayer{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)setNavBarHidden:(BOOL)hide{
    
    _navBarHidden=hide;
    if (hide==YES) {
        [self.navBarView setHidden:YES];
        // self.navigationController.navigationBar.hidden=YES;
    }else{
        [self.navBarView setHidden:NO];
        
        // self.navigationController.navigationBar.hidden=NO;
    }
    
    if (self.navBarHidden==YES) {
        self.originY=0;
    }else{
        if (iPhoneX) {
            self.originY=84;
        }else{
            self.originY=64;
        }
    }
    
}

-(void)setNavBar{
    
    if (!self.navBarView) {
        self.navBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.originY)];
        
        self.navBarTitlelabel=[[UILabel alloc] initWithFrame:CGRectMake(0, self.statusBarHeight, 300, 44)];
        self.navBarTitlelabel.center=CGPointMake(self.navBarView.center.x, self.navBarTitlelabel.center.y);
        
        [self.navBarTitlelabel setFont:[UIFont boldSystemFontOfSize:20]];
        self.navBarTitlelabel.textColor=[UIColor whiteColor];
        [self.navBarTitlelabel setTextAlignment:NSTextAlignmentCenter];
        
        self.navBarView.backgroundColor=[CommData shareInstance].skinColor;
        self.navBarTitlelabel.backgroundColor=[UIColor clearColor];
        [self.navBarView addSubview:self.navBarTitlelabel];
        
        [self.view addSubview:self.navBarView];
        
        if (self.self.navigationController.viewControllers.count>1) {
            self.backBtn=[[UIButton alloc] initWithFrame:CGRectMake(margin, self.statusBarHeight +7, 30, 30)];
            
            
            [self.backBtn addTarget:self action:@selector(backbtnPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.backBtn setImage:[UIImage imageNamed:@"navigationbar_pic_back_icon"] forState:UIControlStateNormal];
            [self.navBarView addSubview:self.backBtn];
            
        } else {
            
            [self setNavLeftBtn];
            //  [self setNavRightBtn];
        }
        
        // [self setSearchBar];
        
    }
    
}
-(void)setNavBarLeftImage{
}
-(void)setSearchBar{
    
}

-(void)setNavLeftBtn
{
    self.navLeftBtn=[[UIButton alloc] initWithFrame:CGRectMake(margin, self.statusBarHeight +7, 30, 30)];
    [self.navLeftBtn addTarget:self action:@selector(navLeftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.navLeftBtn setImage:[UIImage imageNamed:@"home_personal_image"] forState:UIControlStateNormal];
    [self.navBarView addSubview:self.navLeftBtn];
}
-(void)setNavRightBtn
{
    self.navRightBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-45, self.statusBarHeight + 8, 40, 28)];
    
    [self.navRightBtn addTarget:self action:@selector(navRightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.navRightBtn setImage:[UIImage imageNamed:@"home_search_image"] forState:UIControlStateNormal];
    [self.navBarView addSubview:self.navRightBtn];
}

-(void)navRightBtnPressed{
    XANewsSearchViewController *searchViewController = [[XANewsSearchViewController alloc]init];
    [self.navigationController pushViewController:searchViewController animated:YES];
}
- (void)navLeftBtnPressed{
    XAPersonCenterViewController *center = [[XAPersonCenterViewController alloc]init];
    [self.navigationController pushViewController:center animated:YES];
}
-(void)setNavBackBtn
{
    self.backBtn=[[UIButton alloc] initWithFrame:CGRectMake(margin, self.statusBarHeight +7, 30, 30)];
    
    [self.backBtn addTarget:self action:@selector(backbtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setImage:[UIImage imageNamed:@"navigationbar_pic_back_icon"] forState:UIControlStateNormal];
    // [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_icon"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:self.backBtn];
    
}
-(void)backbtnPressed{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - loadingView
-(void)setLoadingView
{
    if (!self.loadingView) {
        self.loadingView=[[JHUD alloc] initWithFrame:CGRectMake(0, self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        self.loadingView.messageLabel.text=LOADING_TITLE;
    }
    
}
#pragma mark -errorView{
-(void)setErrorViewWithCode:(NSInteger)errorCode;
{
    
    if (self.errorView==nil) {
        self.errorView =[[UIView alloc] initWithFrame:CGRectMake(0, self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        
        self.errorView.backgroundColor=[UIColor whiteColor];
        
        _errorImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"request_error"]];
        _errorImageView.frame = CGRectMake((ScreenWidth-173)/2, 80, 173, 180);
        [self.errorView addSubview:_errorImageView];
        _errorBtn=[[UIButton alloc] initWithFrame:self.errorView.bounds];
        _errorBtn.center=self.errorView.center;
        [_errorBtn setTitleColor:[CommData shareInstance].commonGrayColor forState:UIControlStateNormal];
        //        [_errorBtn setTitle:@"找不到页面，请稍后再试" forState:UIControlStateNormal];
        [_errorBtn setContentMode:UIViewContentModeScaleAspectFill];
        [_errorBtn addTarget:self action:@selector(reLoadRequest) forControlEvents:UIControlEventTouchUpInside];
        _errorBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = NOT_FIND_PAGE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [CommData shareInstance].commonGrayColor;
        _titleLabel.font =[UIFont systemFontOfSize:16];
        _titleLabel.frame = CGRectMake(0, _errorImageView.bottom +10, ScreenWidth, 44);
        [self.errorView addSubview:_titleLabel];
        
        _clickLabel = [[UILabel alloc]init];
        _clickLabel.text = @"点击刷新";
        _clickLabel.textAlignment = NSTextAlignmentCenter;
        _clickLabel.textColor = [CommData shareInstance].commonGrayColor;
        _clickLabel.font =[UIFont systemFontOfSize:16];
        _clickLabel.frame = CGRectMake(0, _titleLabel.bottom+30, ScreenWidth, 44);
        [self.errorView addSubview:_clickLabel];
        
        [self.errorView addSubview:_errorBtn];
        [self.view addSubview:self.errorView];
    }else{
        [self.errorView setHidden:NO];
        [self.view addSubview:self.errorView];
    }
    if(errorCode ==-1009){
        _errorImageView.image = [UIImage imageNamed:@"net_error"];
        _titleLabel.text = CHECK_NETWORK;
    } else if(errorCode ==-10){
        _errorImageView.image = [UIImage imageNamed:@"building_icon"];
        _titleLabel.text = PAGE_BUIDING;
        _clickLabel.hidden = YES;
    }else{
        _errorImageView.image = [UIImage imageNamed:@"request_error"];
        _titleLabel.text = NOT_FIND_PAGE;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(TopicModel *)getTopicModelWithDic:(NSDictionary *)topicDic
{
    
    return [[TopicModel alloc] initWithDictionary:topicDic];
    
}
#pragma mark - 刷新，加载更多
-(void)startLoad
{
    
}
-(void)refresh
{
    
}
-(void)loadMore
{
    
}
- (void)reLoadRequest
{
    
}
#pragma mark -  tapSearchview 搜索页面
-(void)searchViewTap{
    
}

-(void)pushViewController:(id)viewController
{
    
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate{
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
    
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return  UIStatusBarStyleLightContent;
    //return [super preferredStatusBarStyle];
}

@end
