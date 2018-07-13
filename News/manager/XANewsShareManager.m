//
//  XANewsShareManager.m
//  News
//
//  Created by mac on 2018/5/11.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANewsShareManager.h"

@implementation XANewsShareManager

+(XANewsShareManager*)defaultManager
{
    return [[self alloc]init];
}
- (void)shareNewsWithTitle:(NSString*)newsTitle newsContent:(NSString*)newsContent thumbImg:(NSString*)thumbImg newsLink:(NSString*)newsLink viewController:(UIViewController*)currentViewController
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:newsTitle descr:newsContent.length==0?@"分享来自雄安天下客户端，请点击打开更多精彩...":newsContent thumImage:(thumbImg==nil||[thumbImg isEqualToString:@""])? [UIImage imageNamed:icon]:thumbImg];
   // UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:newsTitle descr:newsContent thumImage:thumbImg];

       messageObject.shareObject = shareObject;
    shareObject.webpageUrl = newsLink;
     [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatFavorite)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        if(platformType == UMSocialPlatformType_Sina){
            messageObject.text = [NSString stringWithFormat:@"%@,%@",newsTitle,newsLink];
            UMShareImageObject *myShareObject = [[UMShareImageObject alloc] init];
            myShareObject.shareImage = (thumbImg==nil||[thumbImg isEqualToString:@""])? [UIImage imageNamed:icon]:thumbImg;
            myShareObject.thumbImage = (thumbImg==nil||[thumbImg isEqualToString:@""])? [UIImage imageNamed:icon]:thumbImg;
            messageObject.shareObject = myShareObject;
        }
        [self shareWithType:[NSNumber numberWithInteger:platformType] messageObject:messageObject viewController:currentViewController];
    }];
}

- (void)shareWithType:(NSNumber *)shareType messageObject:(UMSocialMessageObject*)messageObject viewController:(UIViewController*)currentViewController {
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:[shareType integerValue] messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
            
        }
        
        
    }];
}

@end
