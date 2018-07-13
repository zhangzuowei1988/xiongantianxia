//
//  XANewsSearchViewController.m
//  News
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANewsSearchViewController.h"

@interface XANewsSearchViewController ()<UITextFieldDelegate>
{
    UITextField *searchTextField;
    UIView *searchHistoryView;
}
@end

@implementation XANewsSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBar];
    self.navBarHidden = YES;
}

- (void)addNavigationBar
{
    UIView *naviBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.originY)];
    naviBarView.backgroundColor = [UIColor colorWithRed:208/255.0 green:2/255.0 blue:27/255.0 alpha:1/1.0];
    [self.view addSubview:naviBarView];
    
    UIView *searchBgView = [[UIView alloc]initWithFrame:CGRectMake(13, self.originY-35, ScreenWidth-73, 28)];
    searchBgView.backgroundColor = [UIColor whiteColor];
    searchBgView.layer.cornerRadius = 13;
    [naviBarView addSubview:searchBgView];
    
    searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(31, 1, searchBgView.width-57, searchBgView.height)];
    [searchBgView addSubview:searchTextField];
    
    UIButton *clearTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearTextButton.frame = CGRectMake(searchBgView.width-26, 0, 24, 28);
    [clearTextButton setImage:[UIImage imageNamed:@"text_clear_image"] forState:UIControlStateNormal];
    [clearTextButton addTarget:self action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
    [searchBgView addSubview:clearTextButton];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_image"]];
    searchImageView.frame = CGRectMake(11, 6, 16, 15);
    [searchBgView addSubview:searchImageView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(ScreenWidth-52, self.originY-42, 42, 42);
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [naviBarView addSubview:backButton];
}

#pragma mark-buttonClick
-(void)clearText
{
    searchTextField.text = nil;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
