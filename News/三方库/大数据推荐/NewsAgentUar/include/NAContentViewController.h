//
//  NAContentViewController.h
//  NewsAgent
//
//  Created by 久其智通 on 2017/12/11.
//  Copyright © 2017年 jiuqizhitong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAContentViewController : UIViewController

@property (nonatomic,copy) NSString *DetailsPageTitle;

-(id)initWithName:(NSString*)viewControllerName;

- (void)setUrl:(NSString *)urlStr ItemInfo:(NSDictionary *)info;

- (void)onItemLoaded:(NSDictionary *)infoDict;

/**
 分享接口
 
 @param shareType 分享到的平台
 @param encodeUri 分享uri
 @param encodett 分享标题
 @param encodetext 分享的内容
 @param encodeImg 分享图片
 */
- (void)shareMyItem:(NSString *)shareType
                uri:(NSString*)encodeUri
                 tt:(NSString*)encodett
               text:(NSString*)encodetext
                img:(NSString*)encodeImg;
@end

