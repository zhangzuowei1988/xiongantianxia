//
//  Base.h
//  WorkRoom
//
//  Created by pdmi on 2017/2/8.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#ifndef Base_h
#define Base_h


/***********************接口相关***********************************/
//测试环境打开注释，生产环境关掉注释
//#define TEST

#ifdef TEST
//测试环境
#define baseUrl        @"http://mp.dev.hubpd.com/xatx/xatxapp/"
//登录接口
#define pupBaseUrl     @"http://oauth.pre.hubpd.com/"
#define client_id      @"ac190024-515c-1e2e-8151-5c6e2e9a0000"
#define client_secret  @"02b5c0bc-9645-4653-b3b2-e2a3aa5648e6"

#else
//生产环境
#define baseUrl         @"http://xatx.hubpd.com/app/"
//登录接口
#define pupBaseUrl      @"http://oauth.iup.hubpd.com/"
#define client_id       @"7f000001-63d9-15c1-8163-d985c1630000"
#define client_secret   @"bbac27f9-4183-492e-9158-e35fec44256d"

#endif


//大数据地址
#define BIGDATA_URL     @"http://rev.uar.hubpd.com/recom"
#define BIGDATA_APPKEY  @"UAR-000279_943"

//雄安发布地址
#define xionganPublishUrl @"https://www.hubpd.com"
//雄安发布列表
#define xionganPublishListUrl   xionganPublishUrl"/json/gzs/xafb/"
//关于我们
#define aboutUsUrl        baseUrl"json/gywm/"

//雄安办事
#define xionganAffairsUrl baseUrl"json/bs/"
//新闻页栏目配置信息
#define configUrl         baseUrl"json/xw/"

/**********************************************************/

#define LOADING_TITLE       @"加载中"
#define NOT_FIND_PAGE       @"找不到页面，请稍后再试"
#define PAGE_BUIDING        @"页面建设中，敬请期待"
#define CHECK_NETWORK       @"当前网络不可用，请检查你的网络"
#define IS_LOADING          @"当前处于移动网络，是否继续下载"
#define LOADING_CURRENT     @"正在下载"
#define Bugly_ID @"e340b1fba0"
#define IS_IPAD   ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define IS_IPHONE   (!IS_IPAD)

#define CURRENT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define iPhone4           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone678    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(375*2, 667*2), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone678Plus    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(414*3, 736*3), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(375*3, 812*3), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)

#define CustomLocalisedString(key,description)    [TSLanguageManager localizedString:key]
#define contains(str1, str2) ([str1 rangeOfString: str2 ].location != NSNotFound)
#define BASECOLOR UIColorFromRGB(0X25be65)



#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? [NSString stringWithFormat:@""]: [NSString stringWithFormat:@"%@", (__X__)]

//栏目个数
#define column_NoAddBtn_num 7


#define screenSize  [UIScreen mainScreen].bounds.size
//当前系统版本号
#define IOS_DEVICEVERSION [[[UIDevice currentDevice] systemVersion] intValue]

//通过RGB，透明度 来设置颜色值
#define  setRGBColor(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//通过颜色值获取颜色
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

//标题字号
# define FirstTitleFontSize  17
# define SecondTitleFontSize  16
# define ThirdTitleFontSize   14
# define FourthTitleFontSize   12

#define  contentTitleFontSize 23
#define  contentAuthorFontSize 12
#define listFontName @"STHeitiSC-Light"

// 标题颜色
#define   backgroundViewColor   UIColorFromRGB(0xEEEEEE)
# define  NewsBlcakColor   UIColorFromRGB(0x222222)
# define  NewsWhiteColor   setRGBColor(255,255,255,1.0)
# define  NewsLightBlcakColor  UIColorFromRGB(0x151515)

#define  NewsLightGrayColor UIColorFromRGB(0xF4F5F7)
#define  NewsGrayColor  UIColorFromRGB(0xBEBEBE)
#define picBorderColor  UIColorFromRGB(0x979797)

#define   backgroundViewColor   UIColorFromRGB(0xEEEEEE)
#define NewslineColor   UIColorFromRGB(0xEEEEEE)

#define ChangedisplayStyle  @"ChangedisplayStyle"
#define SwithSunAndNightNotification  @"SwithSunAndNightNotification"
#define SwithSunAndNightNotification  @"SwithSunAndNightNotification"
#define NetWorkChangeNotification  @"netWorkChange"

//计算字符串的高度
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define XA_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define XA_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif
#define tableViewBackGroundcolor  UIColorFromRGB(0xEBEBEB)
#endif /* Base_h */
