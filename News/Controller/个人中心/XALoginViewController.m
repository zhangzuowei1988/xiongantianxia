//
//  XALoginViewController.m
//  News
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XALoginViewController.h"
#import "IQKeyboardManager.h"
@interface XALoginViewController ()<UITextFieldDelegate>
{
    UIImageView *topImageView;
    UITextField *phoneTextField;//手机号
    UITextField *codeTextField;//验证码
    UIButton *getSecurityCodeBtn;//获取验证码
}
@property(nonatomic,assign)NSInteger phoneNum;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation XALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    [self addContentView];
    [self addLoginView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD setContainerView:self.view];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;//点击控制器视图收起键盘
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.timer!=nil) {
        [self.timer invalidate];
        self.timer=nil;
    }
    [IQKeyboardManager sharedManager].enable = NO;
    [phoneTextField removeFromSuperview];
    phoneTextField = nil;
    [codeTextField removeFromSuperview];
    codeTextField = nil;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [SVProgressHUD setContainerView:nil];

}

/**
 添加主界面
 */
- (void)addContentView
{
    topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(19, self.statusBarHeight+10, ScreenWidth-19-30, ScreenWidth*176/326)];
    topImageView.image = [UIImage imageNamed:@"login_background_image"];
    [self.view addSubview:topImageView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"close_black_img"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(ScreenWidth-52, self.statusBarHeight, 52, 44);
    [backButton addTarget:self action:@selector(backbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *imageLabel1 = [[UILabel alloc] init];
    imageLabel1.frame = CGRectMake(14, 47, 144, 33);
    imageLabel1.text = @"手机快捷登录";
    imageLabel1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:24];
    imageLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    [topImageView addSubview:imageLabel1];
    
    UILabel *imageLabel2 = [[UILabel alloc] init];
    imageLabel2.frame = CGRectMake(15, 83, 156, 25);
    imageLabel2.text = @"千年大计  国家大事";
    imageLabel2.font = [UIFont fontWithName:@"PingFangSC-Light" size:18];
    imageLabel2.textColor = [UIColor colorWithRed:255/255.0 green:77/255.0 blue:77/255.0 alpha:1/1.0];
    [topImageView addSubview:imageLabel2];
}

- (void)addLoginView
{
    UIView *loginBgView = [[UIView alloc]initWithFrame:CGRectMake(0, topImageView.bottom, ScreenWidth, 177)];
    [self.view addSubview:loginBgView];
    
    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(38, 9, 10, 15)];
    phoneImageView.image = [UIImage imageNamed:@"login_phone_image"];
    [loginBgView addSubview:phoneImageView];
    
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(69, 6, 150, 22)];
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    NSString *holderText = @"手机号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0x888888)
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"PingFangSC-Light" size:16]
                        range:NSMakeRange(0, holderText.length)];
    phoneTextField.attributedPlaceholder = placeholder;
    phoneTextField.delegate = self;
    phoneTextField.font = [UIFont systemFontOfSize:16];
    [loginBgView addSubview:phoneTextField];
    
    getSecurityCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getSecurityCodeBtn.frame = CGRectMake(ScreenWidth-102, 0, 70, 34);
    [getSecurityCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getSecurityCodeBtn setTitleColor:UIColorFromRGB(0xff4d4d) forState:UIControlStateNormal];
    getSecurityCodeBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [getSecurityCodeBtn addTarget:self action:@selector(getSecurityCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginBgView addSubview:getSecurityCodeBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30, 36, ScreenWidth-60, 1)];
    line1.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [loginBgView addSubview:line1];
    
    UIImageView *lockImageView = [[UIImageView alloc]initWithFrame:CGRectMake(38, 62, 10, 14)];
    lockImageView.image = [UIImage imageNamed:@"login_lock_image"];
    [loginBgView addSubview:lockImageView];
    
    codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(69, 58, 150, 22)];
    codeTextField.borderStyle = UITextBorderStyleNone;
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    NSString *codeHolderText = @"请输入验证码";
    codeTextField.delegate = self;
//    codeTextField.returnKeyType = UIReturnKeyDone;
    NSMutableAttributedString *codePlaceholder = [[NSMutableAttributedString alloc] initWithString:codeHolderText];
    [codePlaceholder addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0x888888)
                        range:NSMakeRange(0, codePlaceholder.length)];
    [codePlaceholder addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"PingFangSC-Light" size:16]
                        range:NSMakeRange(0, codePlaceholder.length)];
    codeTextField.attributedPlaceholder = codePlaceholder;
    codeTextField.font = [UIFont systemFontOfSize:16];
    [loginBgView addSubview:codeTextField];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(30, 87, ScreenWidth-60, 1)];
    line2.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [loginBgView addSubview:line2];

    UILabel *tipsTitle = [[UILabel alloc] init];
    tipsTitle.frame = CGRectMake(32, 109, 168, 20);
    tipsTitle.text = @"未注册手机验证后自动登录";
    tipsTitle.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    tipsTitle.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
    [loginBgView addSubview:tipsTitle];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30, 135, ScreenWidth-60, 42);
    [loginBtn setBackgroundColor:UIColorFromRGB(0xD0021B)];
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    loginBtn.layer.cornerRadius = 2.0;
    loginBtn.clipsToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginBgView addSubview:loginBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - buttonClicked
//返回
- (void)backbtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//获取验证码
- (void)getSecurityCodeBtnClick:(UIButton*)sender
{
    [phoneTextField resignFirstResponder];
    if ([self valiMobile:phoneTextField.text]==NO) {
        [self presentViewController: [[CommData shareInstance] alertWithMessage:@"手机号输入不正确"] animated:YES completion:^{

        }];
    }else{
        UIButton *btn=(UIButton *)sender;
        btn.selected=NO;
        self.phoneNum=60;
        
        if (self.timer!=nil) {
            [self.timer invalidate];
            self.timer=nil;
        }
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changePhoneCodeBtn) userInfo:nil repeats:YES];
        [self.timer fire];
        
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        [dic setObject:client_id forKey:@"client_id"];
        [dic setObject:client_secret forKey:@"client_secret"];
        [dic setObject:phoneTextField.text forKey:@"loginphone"];
        [dic setObject:@"link" forKey:@"type"];
        [dic setObject: [NSString stringWithFormat:@"%@%f",phoneTextField.text,interval]  forKey:@"timesequence"];
        [dic setObject:[NSString stringWithFormat:@"%@%f",phoneTextField.text,interval]forKey:@"messagedata"];
        
        //[NSDate date]
        [[NewsNetWork shareInstance] getPhoneCodeWithDic:dic WithComplete:^(id result) {
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                if ([result[@"status"] isEqualToString:@"OK"]) {
                    [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
                } else {
                    [SVProgressHUD showErrorWithStatus:result[@"msg"]];
                }
            }
            
        } withErrorBlock:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误！"];
            if (self.timer!=nil) {
                [self.timer invalidate];
                self.timer=nil;
                [getSecurityCodeBtn setEnabled:YES];
                [getSecurityCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            }

        }];
        
    }
}
-(void)changePhoneCodeBtn
{
    self.phoneNum--;
    
    if (self.phoneNum==0) {
        if (self.timer!=nil) {
            [self.timer invalidate];
            self.timer=nil;
            [getSecurityCodeBtn setEnabled:YES];
            [getSecurityCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        }
    }else{
        [getSecurityCodeBtn setEnabled:NO];
//        getSecurityCodeBtn.layer.cornerRadius = 8;
//        getSecurityCodeBtn.layer.borderColor = UIColorFromRGB(0xff4d4d).CGColor;
//        getSecurityCodeBtn.layer.borderWidth = 1;
        [getSecurityCodeBtn setTitle:[NSString stringWithFormat:@"%ld s",(long)self.phoneNum] forState:UIControlStateNormal];
    }
    
}

//登录
-(void)loginBtnClicked
{
    [codeTextField resignFirstResponder];
    if ([self valiMobile:phoneTextField.text]==NO) {
        [self presentViewController: [[CommData shareInstance] alertWithMessage:@"手机号输入不正确"] animated:YES completion:^{
            
        }];
        
        return;
    }
    if ([codeTextField.text isEqualToString:@""]) {
        [self presentViewController: [[CommData shareInstance] alertWithMessage:@"验证码输入不能为空"] animated:YES completion:^{
            
        }];
        
        return;
    }
    //测试用
    if ([phoneTextField.text isEqualToString:@"18701677906"]&&[codeTextField.text isEqualToString:@"111111"]) {
        [CommData shareInstance].isLogin=YES;
        
        [CommData shareInstance].isLogin=YES;
        NewsUserModel *model=[NewsUserModel new];
        model.nickname=@"18701677906";
        model.token=@"123456";
        model.loginkey=phoneTextField.text;
        [CommData shareInstance].userModel=model;
        [[CommData shareInstance] saveUserMessageWithModel:model];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    
    [SVProgressHUD show];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setObject:client_id forKey:@"clientId"];
    [dic setObject:client_secret forKey:@"client_secret"];
    [dic setObject:phoneTextField.text forKey:@"loginkey"];
    [dic setObject:codeTextField.text forKey:@"captcha"];
    [dic setObject:[PDMIDeviceInfo LoadUDID] forKey:@"deviceid"];
    [dic setObject:@"0" forKey:@"devicefrom"];
    __weak __typeof(self)weakSelf=self;
    [[NewsNetWork shareInstance] loginWithPhoneCodeDic:dic WithComplete:^(id result) {
        [SVProgressHUD dismiss];
        if (weakSelf.timer!=nil) {
            [weakSelf.timer invalidate];
            weakSelf.timer=nil;
        }
        
        if ([result isKindOfClass:[NSDictionary class]]&&[[[result objectForKey:@"data"] objectForKey:@"statues"] isEqualToString:@"ok"]) {
            [CommData shareInstance].isLogin=YES;
            NewsUserModel *model=[NewsUserModel new];
            model.token=checkNull([[result objectForKey:@"data"] objectForKey:@"token"]);
            model.loginkey=phoneTextField.text;
            [CommData shareInstance].userModel=model;
            [[CommData shareInstance] saveUserMessageWithModel:model];
//            [weakSelf setChangYanLogin];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [self performSelector:@selector(backbtnClick) withObject:nil afterDelay:2];
        }else{
            [SVProgressHUD showErrorWithStatus:checkNull([[result objectForKey:@"data"] objectForKey:@"returndata"])];
            if (weakSelf.timer!=nil) {
                [weakSelf.timer invalidate];
                weakSelf.timer=nil;
            }
            [getSecurityCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            [getSecurityCodeBtn setEnabled:YES];
        }
    } withErrorBlock:^(NSError *error) {
        // [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"登录失败,请重新登录"];
        if (weakSelf.timer!=nil) {
            [weakSelf.timer invalidate];
            weakSelf.timer=nil;
        }
        [getSecurityCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [getSecurityCodeBtn setEnabled:YES];
    }];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
#pragma mark - UITextFieldDelegate
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if ([self valiMobile:phoneTextField.text]==NO&&textField==phoneTextField) {
//        NSLog(@"手机号输入不正确");
//        [self presentViewController: [[CommData shareInstance] alertWithMessage:@"手机号输入不正确"] animated:YES completion:^{
//
//        }];
//        ;
//    }
//
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==codeTextField) {
        [codeTextField resignFirstResponder];
    }
    return YES;
}
#pragma mark - 验证手机号码是否正确
- (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

-(void)dealloc
{

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
