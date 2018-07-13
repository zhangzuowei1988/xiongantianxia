//
//  CommData.m
//  WorkRoom
//
//  Created by pdmi on 2017/2/15.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "CommData.h"
#import "PDMISandboxFile.h"
#import "Base.h"
#import "PDMITagItem.h"
#import "SSZipArchive.h"
#import "PDMISandboxFile.h"
@interface CommData()

@property(nonatomic,strong)UIAlertController *alertController;
@end

@implementation CommData

+(CommData *)shareInstance
{
    static CommData *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[CommData alloc] init];
        manager.readedData=[[NSMutableDictionary alloc] init];
       
    });
    return manager;
}
-(id)init{
    if(self=[super init]){
       
        NSLog(@"%f",ScreenWidth);
        NSInteger width=ScreenWidth;
        if (width!=375) {
            self.scale=ScreenWidth/375.00;
        }else{
            self.scale=1.0;
        }
        self.percent=1.0;
        self.placeholderImage=[UIImage imageNamed:@"placeholder"];
        self.placeHolderOrgheaderImage=[UIImage imageNamed:@"common_orgPic"];

        self.commonLeftMargin=10*self.scale;
        self.commonRightMargin=10*self.scale;
    }
    return self;
}

#pragma mark - 弹框
-(UIAlertController *)alertWithMessage:(NSString*)message{
    //if (self.alertController==nil) {
        self.alertController=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }]];
   // }
    return  self.alertController;
}

#pragma  mark  -获取订阅的栏目
-(NSArray *)getOrderedColumnDataWithTabId:(NSString *)tabId
{
    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"orderColumnData_2%@.plist",tabId]];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

#pragma mark - 存储订阅的栏目
-(BOOL)saveOrderedColumnData:(NSArray *)orderArr withTabId:(NSString *)tabId;{
   
  NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"orderColumnData_2%@.plist",tabId]];
   return [NSKeyedArchiver archiveRootObject:orderArr toFile:filePath
           ];
}



#pragma mark - 存储个人登录信息
//存储个人登录信息
-(BOOL)saveUserMessageWithModel:(NewsUserModel *)model
{
    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:@"userMessage"];
    return  [NSKeyedArchiver archiveRootObject:model toFile:filePath
             ];
}
#pragma mark - 获取个人用户信息
//获取个人用户信息
-(NewsUserModel *)getUserMessageModel
{
    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:@"userMessage"];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

}
#pragma mark -
-(NSString *)getConfigureImagePath
{
    NSString *imagPath=[[self getConfigurePath ] stringByAppendingPathComponent:@"/tabImage"];
    
    if ([PDMISandboxFile isFileExists:imagPath]==NO) {
        [PDMISandboxFile createFilePath:imagPath error:nil];
    }
    
    return [[self getConfigurePath ] stringByAppendingPathComponent:@"/tabImage"];
}
-(BOOL)unzipConfigureFileAtPath:(NSString *)zipPath
{
   NSString *destinationPath=[self getConfigurePath];
    NSError *error;
    if ([PDMISandboxFile createFilePath:destinationPath error:&error]==YES) {
        if ([SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath]==YES) {
            [PDMISandboxFile deleteFile:zipPath error:nil];
            return YES;
        }else{
            return NO;
        }
    } else{
        NSLog(@"%@",error);
        return NO;
    }
}
-(NSString *)getConfigurePath
{
    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:@"config"];
    
    if ([PDMISandboxFile isFileExists:filePath]==NO) {
        [PDMISandboxFile createFilePath:filePath error:nil];
    }
   return filePath;
   
}
-(NSString *)
getConfigureJsonPath{
    return [[self getConfigurePath] stringByAppendingPathComponent:@"list.json"];
}
-(NSString *)getConfigureTempPath
{
    return [[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:@"tempConfi.zip"];

}
-(VersionModel *)verisionModel{
    if (_verisionModel==nil) {
        
         NSString *jsonStr=[[NSString alloc] initWithContentsOfFile:[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:@"config/version.txt"] encoding:NSUTF8StringEncoding error:nil];
        
        _verisionModel=[[VersionModel alloc] initWithDictionary:[[jsonStr JSONObject] objectForKey:@"data"]];
        self.configModel=_verisionModel.configModel;
        
    }
    return _verisionModel;
}


#pragma mark -
//-(NSDictionary *)getReadData
//{
//    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:@"readData.plist"];
//    
//    return [NSDictionary dictionaryWithContentsOfFile:filePath];
//}
//-(BOOL)saveReadData:(NSDictionary *)readDic
//{
//    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:@"readData.plist"];
//   
//    return  [readDic writeToFile:filePath atomically:YES];
//
//}


-(UIFont*)setLabelFountWithSize:(CGFloat)size{
    
    UIFont * font =  [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    if(font==nil){
        font =[UIFont fontWithName:@"ArialMT" size:size];
    }
    return font;
}


//-(UIColor*)toUIColorByStr:(NSString*)colorStr{
//    
//    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    
//    if ([cString hasPrefix:@"0X"]) {
//        cString = [cString substringFromIndex:2];
//    }else if ([cString hasPrefix:@"#"]){
//        cString = [cString substringFromIndex:1];
//    }
//    
//    
//    
//    if ([cString length] != 6){
//        return [UIColor blackColor];
//    }
//    
//    // Separate into r, g, b substrings
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    NSString *rString = [cString substringWithRange:range];
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    // Scan values
//    unsigned int r, g, b;
//    
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    
//    return [UIColor colorWithRed:((float) r / 255.0f)
//                           green:((float) g / 255.0f)
//                            blue:((float) b / 255.0f)
//                           alpha:1.0f];
//}

-(void)setIsNight:(BOOL)isNight{
    
    if (_isNight!=isNight) {
        _isNight=isNight;
    }
    
    if (_isNight==YES) {
        
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        if (self.gradientLayer==nil) {
            self.gradientLayer = [CAGradientLayer layer];
            self.gradientLayer.frame=CGRectMake(0, 0, screenSize.width, screenSize.height);
            self.gradientLayer.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
            [window.layer addSublayer:self.gradientLayer];
 
        }
        
    }else{
        if (self.gradientLayer!=nil) {
            [self.gradientLayer removeFromSuperlayer];
            self.gradientLayer=nil;
        }
    }
}

-(UIColor *)skinColor{
    return self.configModel.skinColor;
}
-(float)scale{
    //return _scale*_percent;
    return 1.0;
}


#pragma mark _colror
-(UIColor*)commonGrayColor{
    if (self.isNight==YES) {
        return [UIColor whiteColor];
    }
    return NewsGrayColor;
}
-(UIColor *)commonLightGrayColor{
    if (self.isNight==YES) {
        return [UIColor whiteColor];
    }
    return NewsLightGrayColor;
}
-(UIColor *)commonBlackColor{
    if (self.isNight==YES) {
        return [UIColor whiteColor];
    }
    return NewsBlcakColor;
}
-(UIColor *)commonLightBlackColor{
    if (self.isNight==YES) {
        return [UIColor whiteColor];
    }
    return NewsLightBlcakColor;
}
-(UIColor *)commonGroundViewColor{
    if (self.isNight==YES) {
        return UIColorFromRGB(0x555555);
    }
    return backgroundViewColor;
}
-(UIColor *)commonBorderColor{
    if (self.isNight==YES) {
        return [UIColor whiteColor];
    }
    return picBorderColor;
}
-(UIColor *)commonBottomViewColor{
    if (self.isNight==YES) {
        return UIColorFromRGB(0x666666);
    }
    return [UIColor whiteColor];
}


#pragma mark - 存储热点
-(NSMutableArray *)getHotspotData
{
    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"Hotspot2%@.plist",@"listArr"]];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

-(void)saveHotspotData:(NSMutableArray *)orderArr{
    
    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"Hotspot2%@.plist",@"listArr"]];
    BOOL success = [NSKeyedArchiver archiveRootObject:orderArr toFile:filePath];
    
    if (success)
    {
        NSLog(@"归档成功");
    }
    
}
- (UIImage *)getPlaceHoldImage:(CGSize)imageSize
{
//    UIGraphicsBeginImageContext(imageSize);
//    CGContextRef cnf = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(cnf, UIColorFromRGB(0xf5f5f5).CGColor);
//    CGContextFillRect(cnf, CGRectMake(0, 0, 48, 48));
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
    return nil;
}

-(void)saveUserInfoData:(NSDictionary *)dict
{
    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"userInfo%@.plist",@"userInfo"]];
    BOOL success = [NSKeyedArchiver archiveRootObject:dict toFile:filePath];
    
    if (success)
    {
        NSLog(@"归档成功");
    }

}
-(NSDictionary*)getUserInfoData
{
    NSString *filePath=[[PDMISandboxFile getDocumentPath ] stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"userInfo%@.plist",@"userInfo"]];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

}

// 获取设备网络状态
+ (NSString *)deviceNetWorkStatus
{
    UIApplication *app = [UIApplication sharedApplication];
    int type = 0;
    if (!iPhoneX) {  // 非iPhone X
        NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            }
        }
    } else {  //iPhone X
        NSArray *array = [[[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        NSArray *children = [array[2] subviews];
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                type = 5;
            } else if ([child isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]){
                return [child valueForKeyPath:@"originalText"];
            }
        }
    }
    
    switch (type) {
        case 1:
            return @"2G";
        case 2:
            return @"3G";
        case 3:
            return @"4G";
        case 5:
            return @"WIFI";
        default:
            return @"UNKNOWN";//代表未知网络
    }
}
@end
