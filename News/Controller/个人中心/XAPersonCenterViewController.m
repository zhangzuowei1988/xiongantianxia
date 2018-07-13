//
//  XAPersonCenterViewController.m
//  News
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAPersonCenterViewController.h"
#import "XAPersonCenterCell.h"
#import "XALoginViewController.h"
#import "XAPersonSettingViewController.h"
#import "XAClearCacheView.h"
#import "XAAboutUsViewController.h"

static NSString *cellID = @"cellID";

@interface XAPersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *headImageView;//用户头像
    UILabel *nickNameLabel;//昵称
    UIButton *phoneLoginButton;//跳转到登录页面按钮
}
@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;//头像点击手势
@end

@implementation XAPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self addTopView];
    [self addTableView];
}

/**
 上面红色的部分
 */
- (void)addTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.statusBarHeight+44+106)];
    topView.backgroundColor = [UIColor colorWithRed:208/255.0 green:2/255.0 blue:27/255.0 alpha:1/1.0];
    [self.view addSubview:topView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"close_white_image"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(ScreenWidth-52, self.statusBarHeight, 52, 44);
    [backButton addTarget:self action:@selector(backbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    
    
    //头像
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(42, self.statusBarHeight+48, 56, 56)];
    headImageView.clipsToBounds = YES;
    headImageView.userInteractionEnabled = YES;
    headImageView.image = [UIImage imageNamed:@"user_photo_default"];
    headImageView.layer.cornerRadius = 28;
    [headImageView addGestureRecognizer:self.tapGesture];
    [topView addSubview:headImageView];
    //昵称
    nickNameLabel = [[UILabel alloc] init];
    nickNameLabel.frame = CGRectMake(110, self.statusBarHeight+44+19, 200, 25);
    nickNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    nickNameLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    nickNameLabel.text = @"点击登录";
    [topView addSubview:nickNameLabel];
    
    phoneLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [phoneLoginButton setImage:[UIImage imageNamed:@"close_white_image"] forState:UIControlStateNormal];
    phoneLoginButton.frame = CGRectMake(110, self.statusBarHeight+44+19, 200, 25);
    [phoneLoginButton addTarget:self action:@selector(phoneLoginClick) forControlEvents:UIControlEventTouchUpInside];
    phoneLoginButton.backgroundColor = [UIColor clearColor];
    if ([CommData shareInstance].isLogin) {
        [headImageView sd_setImageWithURL:[NSURL URLWithString:[CommData shareInstance].userModel.headpicpath] placeholderImage:[UIImage imageNamed:@"user_photo_default"]];
        nickNameLabel.text = [CommData shareInstance].userModel.nickname;
    }
    [topView addSubview:phoneLoginButton];
}

/**
 图片添加手势

 @return
 */
-(UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTaped)];
    }
    return _tapGesture;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([CommData shareInstance].isLogin) {
        [self getUsetInfoRequest];
        
    } else {
        headImageView.image = [UIImage imageNamed:@"user_photo_default"];
        nickNameLabel.text = @"点击登录";
    }
}

/**
 获取用户信息
 */
- (void)getUsetInfoRequest
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setObject:client_id forKey:@"client_id"];
    [dic setObject:client_secret forKey:@"client_secret"];
    [dic setObject:[CommData shareInstance].userModel.loginkey forKey:@"loginkey"];
    [dic setObject:[CommData shareInstance].userModel.token forKey:@"token"];
    [[NewsNetWork shareInstance] getPersonInformationWithComplete:^(id result) {
        NSDictionary *dataDict = result;
        if (dataDict) {
            //如果接口没有头像取本地头像
            if ([CommData shareInstance].userModel.headpicpath.length==0) {
                NSDictionary *dict  = [[CommData shareInstance] getUserInfoData];
                if(dict&&dict[@"headpicpath"]) {
                headImageView.image = [UIImage imageWithData:dict[@"headpicpath"]];
                }else {
                    headImageView.image = [UIImage imageNamed:@"user_photo_default"];
                }
            } else {
            [headImageView sd_setImageWithURL:[NSURL URLWithString:[CommData shareInstance].userModel.headpicpath] placeholderImage:[UIImage imageNamed:@"user_photo_default"]];
            }
            nickNameLabel.text = [CommData shareInstance].userModel.nickname;
        }
    } withErrorBlock:^(NSError *error) {
        //如果网络获取失败也加载本地头像
        NSDictionary *dict  = [[CommData shareInstance] getUserInfoData];
        if(dict&&dict[@"headpicpath"]) {
            headImageView.image = [UIImage imageWithData:dict[@"headpicpath"]];
        }else {
            headImageView.image = [UIImage imageNamed:@"user_photo_default"];
        }

    }];
}

- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.statusBarHeight+150, ScreenWidth, self.view.height-self.statusBarHeight-150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerClass:[XAPersonCenterCell class] forCellReuseIdentifier:cellID];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XAPersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLabel.text = @"个人设置";
            cell.rightLabel.text = nil;
        }
            break;
        case 8:
            cell.titleLabel.text = @"认证资质";
            cell.rightLabel.text = nil;
            break;
        case 1:
            cell.titleLabel.text = @"清理缓存";
            cell.rightLabel.text = [NSString stringWithFormat:@"%.1fMB",(float)([SDImageCache sharedImageCache].getSize / 1024 /1024)] ;
            break;
        case 2:
            cell.titleLabel.text = @"关于我们";
            cell.rightLabel.text = nil;
            
            break;
            
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            if (![CommData shareInstance].isLogin) {
                XALoginViewController *loginVC = [[XALoginViewController alloc]init];
                [self.navigationController pushViewController:loginVC animated:YES];
            } else {
                XAPersonSettingViewController *sVC = [[XAPersonSettingViewController alloc]init];
                [self.navigationController pushViewController:sVC animated:YES];
            }
        }
            break;
        case 1:
        {
            XAClearCacheView *selectTimeV = [[XAClearCacheView alloc] initWithFrame:[UIScreen mainScreen].bounds];            selectTimeV.block = ^(void) {
                [SVProgressHUD showWithStatus:@"清理中"];
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    [SVProgressHUD showSuccessWithStatus:@"清理完成"];
                }];
                [[SDImageCache sharedImageCache] clearMemory];
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
        }
            break;
        case 2:
        {
            XAAboutUsViewController *vc = [[XAAboutUsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - buttonClicked
//返回
- (void)backbtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//手机号登录
-(void)phoneLoginClick
{
    if ([CommData shareInstance].isLogin) {
        XAPersonSettingViewController *sVC = [[XAPersonSettingViewController alloc]init];
        [self.navigationController pushViewController:sVC animated:YES];
    }else {
    XALoginViewController *loginVC = [[XALoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
    }
}
//点击头像
- (void)imageTaped
{
    
    if ([CommData shareInstance].isLogin) {
        XAPersonSettingViewController *sVC = [[XAPersonSettingViewController alloc]init];
        [self.navigationController pushViewController:sVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
