//
//  BaseViewController.h
//  News
//
//  Created by pdmi on 2017/5/2.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDMIJSON.h"
#import "TopicModel.h"
#import "PageModel.h"
#import "JHUD.h"
static NSInteger toolBarHeight=50;
@interface BaseViewController : UIViewController

@property(nonatomic)BOOL navBarHidden;//是否隐藏导航条
@property(nonatomic,strong)UILabel *navBarTitlelabel;//导航条标题
@property(nonatomic,strong)UIButton *navRightBtn;//导航条右面的按钮
@property(nonatomic,strong)UIButton *navLeftBtn;//导航条左边的按钮
@property(nonatomic,strong)UIView *navBarView;//自定义导航条
@property(nonatomic,strong)UIButton *backBtn;//返回按钮
@property(nonatomic)CGFloat originY;
@property(nonatomic)CGFloat tabHeight;
@property(nonatomic,strong)PageModel *pageModel;
@property(nonatomic,strong)PDMITagItem *columItem;
@property(nonatomic)CGRect contentViewFrame;
@property(nonatomic)CGFloat statusBarHeight;//状态栏高度
@property(nonatomic,strong)JHUD *loadingView;
@property(nonatomic,strong)UIView *errorView;//页面加载错误页面

/**
 加载导航控制器

 @param viewController 需要加载的控制器
 */
-(void)pushViewController:(id)viewController;

/**
 设置自定义导航条
 */
-(void)setNavBar;

/**
 设置导航条的返回按钮
 */
-(void)setNavBackBtn;

/**
 设置导航条上右边的按钮
 */
-(void)setNavRightBtn;

/**
 设置导航条上左边的按钮
 */
-(void)setNavLeftBtn;

/**
 导航条上右边按钮点击响应
 */
-(void)navRightBtnPressed;

/**
 返回按钮点击响应
 */
-(void)backbtnPressed;

/**
 设置导航条上左边的图片
 */
-(void)setNavBarLeftImage;

/**
 刷新
 */
-(void)refresh;

/**
 加载更多
 */
-(void)loadMore;

/**
 开始加载
 */
-(void)startLoad;

/**
 从新加载
 */
-(void)reLoadRequest;


/**
 设置搜索框
 */
-(void)setSearchBar;

/**
 设置loading框
 */
-(void)setLoadingView;

/**
 设置加载错误界面

 @param errorCode 根据不同的errorCode设置不同的错误界面
 */
-(void)setErrorViewWithCode:(NSInteger)errorCode;

@end
