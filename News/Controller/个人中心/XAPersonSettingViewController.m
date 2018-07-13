//
//  XAPersonSettingViewController.m
//  News
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAPersonSettingViewController.h"
#import "XAPersonSettingCell.h"
#import "XASexSelectView.h"
#import "XAPhotoSelectView.h"
#import "XASelectDatePicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "MAgent.h"
#import "PDMISandboxFile.h"
#define margin 12
static NSString *cellId = @"cellId";
@interface XAPersonSettingViewController ()<UITableViewDelegate,UITableViewDataSource,XASexSelectViewDelegate,XAPhotoSelectViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *_tableView;
    NSArray *titleArray;
}
@property(nonatomic,weak)UITextField *currentTextField;//当前正在操作的输入框
@property(nonatomic,strong)UIImage *photoImage;//选中的图片

@end

@implementation XAPersonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray = @[@[@"头像",@"用户名",@"简介"],/*@[@"性别",@"生日",@"地区"]*/];
    [self addNaviaBar];
    [self addTableView];
}

/**
 控制器退出时，移除输入框

 */
-(void)willMoveToParentViewController:(UIViewController *)parent
{
    //防止内存泄漏
    if (parent==nil) {
        XAPersonSettingCell *nickNameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        XAPersonSettingCell *careerNameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        [nickNameCell.itemSubTitleTextField removeFromSuperview];
        [careerNameCell.itemSubTitleTextField removeFromSuperview];
        nickNameCell.itemSubTitleTextField =nil;
        careerNameCell.itemSubTitleTextField =nil;
    }
}

/**
 添加自定义导航条
 */
- (void)addNaviaBar
{
    self.navBarView.backgroundColor = [CommData shareInstance].skinColor;
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.originY-1, ScreenWidth, 1)];
    bottomLine.backgroundColor =UIColorFromRGB(0xe5e5e5);//UIColorFromRGB(0xe5e5e5); //;
    [self.navBarView addSubview:bottomLine];
    [self.backBtn setImage:[UIImage imageNamed:@"navigationbar_pic_back_icon"] forState:UIControlStateNormal];
    self.navBarTitlelabel.text =@"个人设置";
    self.navBarTitlelabel.font = [UIFont boldSystemFontOfSize:20];

    self.navBarTitlelabel.textColor =[UIColor whiteColor]; //[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    //保存按钮
    self.navRightBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, self.statusBarHeight + 8, 40, 28)];
    
    [self.navRightBtn addTarget:self action:@selector(saveButton) forControlEvents:UIControlEventTouchUpInside];
    [self.navRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navRightBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.navRightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.navBarView addSubview:self.navRightBtn];
}

- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.originY, ScreenWidth, self.view.height-self.originY) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView registerClass:[XAPersonSettingCell class] forCellReuseIdentifier:cellId];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [self.view addSubview:_tableView];
    [self.view addSubview:self.footView];
}

/**
 退出按钮

 */
- (UIView*)footView
{
    UIView *footBgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-45, ScreenWidth, 45)];
    if (iPhoneX) {
        footBgView.top = footBgView.top-34;
        footBgView.height = footBgView.height+34;
    }
    footBgView.backgroundColor = [UIColor whiteColor];
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake((ScreenWidth-100)/2.0, 0, 100, 45);
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchDown];
    [logoutBtn setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];
    [footBgView addSubview:logoutBtn];
    return  footBgView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XAPersonSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.itemTitleLabel.text = titleArray[indexPath.section][indexPath.row];
    NSDictionary *dict  = [[CommData shareInstance] getUserInfoData];

    if (indexPath.section == 0 ) {
        if (indexPath.row==0) {
            //如果接口没有头像取本地头像

            if ([CommData shareInstance].userModel.headpicpath.length==0) {
                if(dict&&dict[@"headpicpath"]) {
                    cell.itemImageView.image = [UIImage imageWithData:dict[@"headpicpath"]];
                }else {
                    cell.itemImageView.image = [UIImage imageNamed:@"user_photo_default"];
                }
            } else {
                [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:[CommData shareInstance].userModel.headpicpath] placeholderImage:[UIImage imageNamed:@"user_photo_default"]];
            }

            cell.itemSubTitleTextField.text = nil;
            cell.itemSubTitleTextField.enabled = NO;
            cell.itemSubTitleTextField.tag = 0;
        } else if (indexPath.row==1){
            cell.itemSubTitleTextField.text = [CommData shareInstance].userModel.nickname;
            cell.itemSubTitleTextField.tag = 1;
            cell.itemSubTitleTextField.enabled = YES;
        } else if (indexPath.row==2) {
            cell.itemSubTitleTextField.tag = 2;
            cell.itemSubTitleTextField.enabled = YES;
            //生产接口暂时有问题，本地存一份用分信息
            if ([CommData shareInstance].userModel.career.length>0) {
                cell.itemSubTitleTextField.text = [CommData shareInstance].userModel.career;
            } else if(dict) {
                cell.itemSubTitleTextField.text = dict[@"career"];

            }
        }
    } else{
        if (indexPath.row == 0) {
            cell.itemSubTitleTextField.text = [CommData shareInstance].userModel.gender;
            cell.itemSubTitleTextField.enabled = NO;
            cell.itemSubTitleTextField.tag = 0;

        } else if (indexPath.row == 1) {
            cell.itemSubTitleTextField.text = [CommData shareInstance].userModel.birthday;
            cell.itemSubTitleTextField.enabled = NO;
            cell.itemSubTitleTextField.tag = 0;

        }
    }
    cell.itemSubTitleTextField.delegate = self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 14;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 14)];
    footView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_currentTextField) {
        [_currentTextField resignFirstResponder];
    }
    if (indexPath.section == 0&& indexPath.row==0) {//选择头像弹窗
        XAPhotoSelectView *selectTimeV = [[XAPhotoSelectView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        selectTimeV.block = ^(UIImagePickerControllerSourceType sourceType) {
            if (sourceType) {
                [self picSelectWithType:sourceType];
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    } else if (indexPath.section==1&&indexPath.row==0) {//性别选择弹窗
        XAPersonSettingCell *sexCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        XASexSelectView *selectTimeV = [[XASexSelectView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        selectTimeV.sex = sexCell.itemSubTitleTextField.text;
        selectTimeV.block = ^(NSString *timeStr) {
            if (timeStr) {
                sexCell.itemSubTitleTextField.text = timeStr;
                  NSDictionary *sexDict = @{@"gender":timeStr};
                    [self modifyUserInfo:sexDict];
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    } else if (indexPath.section ==1&&indexPath.row==1 ){//生日选择弹窗
        XASelectDatePicker *selectTimeV = [[XASelectDatePicker alloc] init];
        selectTimeV.block = ^(NSString *timeStr) {
            if (timeStr) {
                XAPersonSettingCell *selectCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                selectCell.itemSubTitleTextField.text = timeStr;
                NSDictionary *sexDict = @{@"birthday":timeStr};
                [self modifyUserInfo:sexDict];
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    } else if (indexPath.section == 0&& indexPath.row==1) {//昵称
           XAPersonSettingCell *nickNameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [nickNameCell.itemSubTitleTextField setEnabled:YES];
        [nickNameCell.itemSubTitleTextField becomeFirstResponder];
    } else if (indexPath.section == 0&& indexPath.row==2) {//简介
        XAPersonSettingCell *careerNameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        careerNameCell.itemSubTitleTextField.enabled = YES;
        [careerNameCell.itemSubTitleTextField becomeFirstResponder];
    }
    
}
#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _currentTextField = textField;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSLog(@"用户名现在---%lu",(unsigned long)range.location);
//    CGFloat maxLength = 14;
//    NSString *toBeString = textField.text;
//
//    //获取高亮部分
//    UITextRange *selectedRange = [textField markedTextRange];
//    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
//    if (!position || !selectedRange)
//    {
//        if (toBeString.length > maxLength&&string.length>0)
//        {
//            textField.text = [textField.text substringToIndex:14];
//            return NO;
////            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
////            if (rangeIndex.length == 1)
////            {
////                textField.text = [toBeString substringToIndex:maxLength];
////            }
////            else
////            {
////                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
////                textField.text = [toBeString substringWithRange:rangeRange];
////            }
//        }
//    }
//    return YES;
//}

/**
 限制输入框输入的字数

 */
- (void)textFieldChange:(UITextField*)textField
{
    NSString *temp = textField.text;
    if (textField.markedTextRange == nil) {
        while(1){
            if ([temp lengthOfBytesUsingEncoding:NSUTF16StringEncoding] <= 14) {
                break;
            }else {
                temp = [temp substringToIndex:temp.length-1];
            }
        }
        textField.text = temp;
    }
}

/**
 选择图片

 */
-(void)picSelectWithType:(UIImagePickerControllerSourceType)type
{

    if (type == UIImagePickerControllerSourceTypeCamera) {
        [self checkCameraAuthority];
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = type;
    [self presentViewController:imagePickerController animated:YES completion:^{
    }];
//        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//        imagePickerVc.allowCrop=YES;
//        imagePickerVc.allowTakePicture=NO;
//        imagePickerVc.circleCropRadius = 100;
//        // You can get the photos by block, the same as by delegate.
//        // 你可以通过block或者代理，来得到用户选择的照片.
//        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//
//            //            SettingCell *cell=(SettingCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
//            //            cell.rightImageView.image=[photos objectAtIndex:0];
//            //            self.photoImage=[photos objectAtIndex:0];
//
//
//        }];
//
//        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
}

/**
 获取用户相机权限
 */
- (void)checkCameraAuthority
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        // 无权限 引导去开启
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"雄安天下不能访问您的相机\r\n请进入【设置】->【隐私】->【相机】 设置权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
        [alertController addAction:cancelAlert];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}
#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取选中的图片
    self.photoImage = [info objectForKey:UIImagePickerControllerEditedImage];
    XAPersonSettingCell *photoCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    photoCell.itemImageView.image = self.photoImage;
//    [self postImage];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//修改头像接口
-(void)postImage{
    
    [SVProgressHUD show];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSData *data = UIImageJPEGRepresentation(self.photoImage, 0.3);
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pupImgaeUrl,[CommData shareInstance].userModel.headpicpath]]];
    if (data || imageData) {
        [dic setObject:data?data:imageData forKey:@"headpicpath"];
    }
    [dic setObject:[CommData shareInstance].userModel.loginkey forKey:@"loginkey"];
    [dic setObject:[CommData shareInstance].userModel.token forKey:@"userid"];
    [dic setObject:client_id forKey:@"client_id"];
    [dic setObject:@"" forKey:@"birthday"];
    [dic setObject:[CommData shareInstance].userModel.career forKey:@"career"];
    [dic setObject:@"" forKey:@"emailbox"];
    [dic setObject:@"" forKey:@"mobilephone"];
    [dic setObject:[CommData shareInstance].userModel.nickname forKey:@"nickname"];
    [dic setObject:@"" forKey:@"gender"];
    [[NewsNetWork shareInstance] requestWithParm:dic success:^(AFHTTPRequestOperation *operation, id result) {
        [SVProgressHUD dismiss];
     //   [weakSelf getUsetInfoRequest];
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"修改失败"];
    }];
}
//修改个人信息接口
- (void)modifyUserInfo:(NSDictionary*)modifyDict
{
    [SVProgressHUD show];

//    __weak __typeof(self)weakSelf = self;
    [[NewsNetWork shareInstance] updatePersonInfomation:modifyDict WithComplete:^(id result) {
        [SVProgressHUD dismiss];
        //  [self getUserMessage];
    //    [weakSelf getUsetInfoRequest];
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    } withErrorBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"修改失败"];
    }];
}
//获取用户信息接口
- (void)getUsetInfoRequest
{

    [[NewsNetWork shareInstance] getPersonInformationWithComplete:^(id result) {
       [_tableView reloadData];
    } withErrorBlock:^(NSError *error) {
    }];
}

#pragma mark - button
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 点击保存按钮
 */
- (void)saveButton
{
    [_currentTextField resignFirstResponder];
    XAPersonSettingCell *nickNameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    XAPersonSettingCell *careerNameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *nickName = nickNameCell.itemSubTitleTextField.text;
    if ([self getToIntWith:nickName]==0) {
        [self presentViewController: [[CommData shareInstance] alertWithMessage:@"昵称不能为空"] animated:YES completion:^{
            
        }];
        return;
    }
    if ([self validateSpecialCharacters:nickName]) {
        if (/*[self getToIntWith:nickName]>=2&&*/[self getToIntWith:nickName]<=14) {
            
        } else {
        [self presentViewController: [[CommData shareInstance] alertWithMessage:@"用户名：中英文均可，最长14个英文或7个汉字"] animated:YES completion:^{
            
        }];
            return;
        }
    } else {
        [self presentViewController: [[CommData shareInstance] alertWithMessage:@"用户名：中英文均可，最长14个英文或7个汉字"] animated:YES completion:^{
            
        }];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    
  //  NSData *data = UIImageJPEGRepresentation(self.photoImage, 0.3);
    
    
//    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pupImgaeUrl,[CommData shareInstance].userModel.headpicpath]]];
//    if (data || imageData) {
//        [dic setObject:data?data:imageData forKey:@"headpicpath"];
//    }
    NSData *data = UIImageJPEGRepresentation(self.photoImage, 0.3);
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[CommData shareInstance].userModel.headpicpath]];
    if(imageData==nil){
        NSDictionary *dict  = [[CommData shareInstance] getUserInfoData];
        if (dict) {
            imageData = dict[@"headpicpath"];
        }
    }
    if (data || imageData) {
        [dic setObject:data?data:imageData forKey:@"headpicpath"];
    }

    [dic setObject:[CommData shareInstance].userModel.loginkey forKey:@"loginkey"];
    [dic setObject:[CommData shareInstance].userModel.token forKey:@"userid"];
    [dic setObject:client_id forKey:@"client_id"];
    [dic setObject:careerNameCell.itemSubTitleTextField.text forKey:@"career"];
    [dic setObject:nickNameCell.itemSubTitleTextField.text forKey:@"nickname"];
    [[NewsNetWork shareInstance] requestWithParm:dic success:^(AFHTTPRequestOperation *operation, id result) {
        
        [SVProgressHUD dismiss];
//        [self getUserMessage];
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        //生产接口暂时有问题，本地存一份用法信息
        [[CommData shareInstance] saveUserInfoData:dic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD dismiss];
    }];
//    NSDictionary *sexDict1 = @{@"nickname":nickNameCell.itemSubTitleTextField.text,
////          @"career":careerNameCell.itemSubTitleTextField.text,
////          @"gender":[CommData shareInstance].userModel.gender,
////          @"birthday":[CommData shareInstance].userModel.birthday
//         };
//    [self modifyUserInfo:sexDict1];
//    NSDictionary *sexDict2 = @{@"career":careerNameCell.itemSubTitleTextField.text};
//    [self modifyUserInfo:sexDict2];
    

}
//是否有特殊字符
- (BOOL)validateSpecialCharacters:(NSString *)nickName
{
    NSString *nickNameRegex = @"[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *nickNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nickNameRegex];
    return [nickNameTest evaluateWithObject:nickName];
}
//获取字符串的长度
- (NSInteger)getToIntWith:(NSString*)str
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [str dataUsingEncoding:enc];
    return [da length];
}

//退出登录
-(void)loginout
{
    [CommData shareInstance].isLogin = NO;
    [CommData shareInstance].userModel = nil;
    NewsUserModel *model = [[NewsUserModel alloc]init];
    [[CommData shareInstance] saveUserMessageWithModel:model];
    [MAgent clearUserId];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
