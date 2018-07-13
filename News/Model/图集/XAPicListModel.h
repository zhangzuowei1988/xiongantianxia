//
//  XAPicListModel.h
//  News
//
//  Created by mac on 2018/5/7.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XAPicListModel : PDMIObjectBase

@property(nonatomic,strong)NSString *imgPath;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *pDescription;
@property(nonatomic,strong)NSString *auth;

@end
