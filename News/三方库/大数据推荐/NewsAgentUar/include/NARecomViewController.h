//
//  NARecomViewController.h
//  NewsAgent
//
//  Created by 久其智通 on 2017/12/11.
//  Copyright © 2017年 jiuqizhitong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NARecomViewController : UIViewController

/**
 重写此方法实现跳转
 
 @param urlstr 详情页url
 @param info 详情页参数
 @param pageTitle 页面的标题
 
 */
- (void)openItem:(NSString *)urlstr ItemInfo:(NSDictionary *)info DetailsPageTitle:(NSString *)pageTitle;

/**
 可创建每次打开重新加载的列表
 
 @param newsSpotTag 资讯位
 @param contentVCName 可选 自定义详情页类名，不填为nil
 @return 实例化
 */
- (instancetype)initWithNewsSpotTag:(NSString*)newsSpotTag contentVCName:(NSString*)contentVCName;
- (void)setDissRecomWbFrameHeight:(CGFloat)dissheight; //* 用户手动去掉recom列表的高度//

@end
