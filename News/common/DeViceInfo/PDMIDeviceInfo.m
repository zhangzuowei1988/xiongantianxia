//
//  PDMIDeviceInfo.m
//  PDMIApi
//
//  Created by luo on 15/3/26.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "PDMIDeviceInfo.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>
#import "sys/sysctl.h"
#import <CoreLocation/CoreLocation.h>
#import "OpenUDID.h"

#import "SSKeychain.h"

//#import "PDMIBaseInfo.h"
//#import "KeychainItemWrapper.h"
static NSString * const kAccountName = @"com.inhouse.doco";

@interface PDMIDeviceInfo()<CLLocationManagerDelegate>{
    
    CLLocationManager *_currentLoaction;
    
}

//- (NSString *)getDeviceId;  //获取设备唯一标识
//
//- (NSString *)getDeviceMode;  //获取设备类型
//
//- (NSString *)getScreenSize;  //获取设备屏幕分辨率
//
//- (NSString *)getsysVersion;  //获取系统版本
//
//- (NSString *)getPlatform;  //获取平台信息
//
//- (NSString *)getNetworkType;  //获取网络类型
//
//- (NSString *)getNetworkOperator;  //获取当前运营商
//
//- (NSString *)getLocation;  //获取位置信息
//
//- (NSString *)getPhoneNumber;  //获取电话号码
//
@end

@implementation PDMIDeviceInfo

+(PDMIDeviceInfo *)shareInstance{
    static PDMIDeviceInfo *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[PDMIDeviceInfo alloc] init];
        
    });
    return manager;
}

///* 初始化个属性值 */
//- (void) create{
//    _deviceId = [self getDeviceId];
//    _deviceMode = [self getDeviceMode];
//    _screenViewSize = [self getScreenSize];
//    _sysVersion = [self getsysVersion];
//    _platform = [self getPlatform];
//    _networkOperator = [self getNetworkOperator];
//    _networkType = [self getNetworkType];
//    _location = [self getLocation];
//    _phoneNumber = [self getPhoneNumber];
//}

/* 设备信息 */
//- (NSString *)deviceInfo{
//    return [self createJsonInfo];
//}

/* 创建设备信息json字符串 */
//- (NSString *)createJsonInfo{
//    NSMutableDictionary * deviceInfo =  [[NSMutableDictionary alloc]init];
//    NSString *deviceId = [self getDeviceId]?[self getDeviceId]:@"";
//    [deviceInfo setObject:deviceId forKey:@"deviceId"];
//    NSString *deviceMode = [self getDeviceMode]?[self getDeviceMode]:@"";
//    [deviceInfo setObject:deviceMode forKey:@"deviceMode"];
//    NSString *screenViewSize = [self getScreenSize]?[self getScreenSize]:@"";
//    [deviceInfo setObject:screenViewSize forKey:@"screenSize"];
//    NSString *sysVersion = [self getsysVersion]?[self getsysVersion]:@"";
//    [deviceInfo setObject:sysVersion forKey:@"sysVersion"];
//    NSString *platform = [self getPlatform]?[self getPlatform]:@"";
//    [deviceInfo setObject:platform forKey:@"platform"];
//    NSString *networkType = [self getNetworkType]?[self getNetworkType]:@"";
//    [deviceInfo setObject:networkType forKey:@"networkType"];
//    NSString *networkOperator = [self getNetworkOperator]?[self getNetworkOperator]:@"";
//    [deviceInfo setObject:networkOperator forKey:@"networkOperator"];
//    NSString *location = [self getLocation]?[self getLocation]:@"";
//    [deviceInfo setObject:location forKey:@"location"];
//    NSString *phoneNumber = [self getPhoneNumber]?[self getPhoneNumber]:@"";
//    [deviceInfo setObject:phoneNumber forKey:@"phoneNumber"];
//    NSString *appInfoSting = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:deviceInfo options:0 error:nil] encoding:NSUTF8StringEncoding];
//    return appInfoSting;
//}

#pragma mark -
#pragma mark personal methods

/* 获取设备唯一标识 */
- (NSString *)deviceId{
    
//    NSString *identifier = [PDMIBaseInfo shareInstance].appInfo.eCode;
//    NSString *groupIdentifier = [PDMIBaseInfo shareInstance].appInfo.appIdentifier;
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:identifier accessGroup:groupIdentifier];
//    NSString *uuid = [wrapper objectForKey:(__bridge id)(kSecValueData)];
//    if (!uuid) {
//        [wrapper setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:(__bridge id)(kSecValueData)];
//    }
    //return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [OpenUDID value];
}
+ (NSString *)LoadUDID
{
    NSString *UDID = [SSKeychain passwordForService:@"UDID" account:kAccountName];
    
    if(!UDID || !UDID.length)
    {
        [[self class] SaveUDID];
    }
    return [SSKeychain passwordForService:@"UDID" account:kAccountName];
}

+ (void)SaveUDID
{
    CFUUIDRef uuid_ref=CFUUIDCreate(nil);
    CFStringRef uuid_string_ref=CFUUIDCreateString(nil, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid=[NSString stringWithString:CFBridgingRelease(uuid_string_ref)];
    
    [SSKeychain setPassword:uuid forService:@"UDID" account:kAccountName];
}
/* 获取设备类型 */
- (NSString *)deviceMode{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *deviceModel = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        ||[deviceModel isEqualToString:@"iPad4,5"]
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        ||[deviceModel isEqualToString:@"iPad4,8"]
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceModel;
    
 }

/* 获取设备屏幕分辨率 */
- (NSString *)screenViewSize{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat screenScale = [UIScreen mainScreen].scale;
    float screenWidth = screenScale * size.width;
    float screenHeight = screenScale * size.height;
    NSString *SizeString = [NSString stringWithFormat:@"%fx%f",screenWidth,screenHeight];
    return SizeString;
}

/* 获取系统版本 */
- (NSString *)sysVersion{
    return [[UIDevice currentDevice] systemVersion];
}

/* 获取平台信息 */
- (NSString *)platform{
    return [[UIDevice currentDevice] systemName];
}

-(NSString *)buildVerison{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    // 获取App的版本号
   // NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    // 获取App的build版本
    NSString *appBuildVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    // 获取App的名称
   // NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    
    return appBuildVersion;
}

/* 获取网络类型 */
- (NSString *)networkType{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])     {
            dataNetworkItemView = subview;
            break;
        }
    }
    int type = [[dataNetworkItemView valueForKey:@"dataNetworkType"] intValue];
    _networkType = @"UNKNOWN";
    switch (type) {
        case 0:
            _networkType = @"UNKNOWN";
            break;
        case 1:
            _networkType = @"2G";
            break;
        case 2:
            _networkType = @"3G";
            break;
        case 3:
            _networkType = @"4G";
            break;
        case 5:
            _networkType = @"WIFI";
            break;
        default:
            break;
    }
    return _networkType;
}

/* 获取当前运营商 */
- (NSString *)networkOperator{
    CTTelephonyNetworkInfo *net = [[CTTelephonyNetworkInfo alloc] init] ;
    CTCarrier *carrier = [net subscriberCellularProvider];
    NSString *mobileNetworkCode =[carrier mobileNetworkCode];
    if ([mobileNetworkCode isEqualToString:@"00"]||[mobileNetworkCode isEqualToString:@"02"]||[mobileNetworkCode isEqualToString:@"07"]) {
        return  @"CM";
    } else if ([mobileNetworkCode isEqualToString:@"06"]||[mobileNetworkCode isEqualToString:@"01"]){
        return @"CU" ;
    }else if ([mobileNetworkCode isEqualToString:@"03"]||[mobileNetworkCode isEqualToString:@"05"]){
        return @"CT" ;
    } else if ([mobileNetworkCode isEqualToString:@"20"]){
        return @"CM";
    } else
        return @"UNKNOWN";
    return  @"UNKNOWN";
}

/* 获取位置信息 */
- (NSString *)getLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (!_currentLoaction) {
                _currentLoaction = [[CLLocationManager alloc] init];
                _currentLoaction.delegate = self;
                _currentLoaction.distanceFilter = kCLDistanceFilterNone;
                _currentLoaction.desiredAccuracy = kCLLocationAccuracyBest;
                [_currentLoaction startUpdatingLocation];
            } else {
                [_currentLoaction startUpdatingLocation];
            }
        });
    }
    return _location;
}

/* 获取电话号码 */
- (NSString *)phoneNumber{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
}


#pragma mark - 
#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = currLocation.coordinate;
    _location  = [NSString stringWithFormat:@"[%.4f,%.4f]",coordinate.latitude, coordinate.longitude];
    [_currentLoaction stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    [_currentLoaction stopUpdatingLocation];
}

@end
