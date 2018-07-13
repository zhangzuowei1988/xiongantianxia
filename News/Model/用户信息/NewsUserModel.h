//
//  NewsUserModel.h
//  News
//
//  Created by pdmi on 2017/9/21.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDMIObjectBase.h"
@interface NewsUserModel : PDMIObjectBase
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *loginkey;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)UIImage *photoImage;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *imgUrl;
@property(nonatomic,strong)NSString *career;
@property(nonatomic,strong)NSString *headpicpath;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *mobilephone;
@property(nonatomic,strong)NSString *emailbox;



//@property(nonatomic,strong)NSString *changyanToken;

@end
