//
//  PDMIDeviceInfo.h
//  PDMIApi
//
//  Created by luo on 15/3/26.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 @header PDMIDeviceInfo.h
 @abstract 此类主要为用户提供设备基本信息
 */

typedef enum {
    NETWORK_TYPE_UNKNOWN = 0,

    NETWORK_TYPE_2G = 1,

    NETWORK_TYPE_3G = 2,

    NETWORK_TYPE_4G = 3,

    NETWORK_TYPE_WIFI = 5,
    
} PDMI_NETWORK_TYPE;

/*! @brief 设备信息数据对象
 *
 * 设备信息数据对象主要包括当前设备的基本信息
 */
@interface PDMIDeviceInfo : NSObject

+(PDMIDeviceInfo *)shareInstance;
/*!
 @property
 @abstract 设备Id,当前设备的唯一标识，通过UDID保存到keychain的方式保证其唯一性
 */
@property (nonatomic, strong) NSString *deviceId;

/*!
 @property
 @abstract 设备型号,当前设备所属型号，例：iPhone4，iPhone5、iPhone6、iPad等
 */
@property (nonatomic, strong) NSString *deviceMode;

/*!
 @property
 @abstract 屏幕分辨率,当前设备屏幕分辨率，格式为：宽x高  例：640x960
 */
@property (nonatomic, strong) NSString *screenViewSize;

/*!
 @property
 @abstract 系统版本,获取当前设备使用的系统版本
 */

@property (nonatomic, strong) NSString *sysVersion;


/*!
 @property
 @abstract 系统类型,当前设备使用系统类型
 */
@property (nonatomic, strong) NSString *platform;

/*!
 @property
 @abstract 网络类型,当前设备使用网络类型 主要有2g、3g、4g、wifi、UNKNOWN
 */
@property (nonatomic, strong) NSString *networkType;

/*!
 @property
 @abstract 网络运营商,当前设备使用的网络所属运营商 主要有：移动、联通、电信
 */
@property (nonatomic, strong) NSString *networkOperator;

/*!
 @property
 @abstract 位置信息,当前设备位置信息,格式：经度，纬度 例：“120，30”
 */
@property (nonatomic, strong) NSString *location;

/*!
 @property
 @abstract 电话号码,当前设备电话号码
 */
@property (nonatomic, strong) NSString *phoneNumber;


@property(nonatomic,strong)NSString *buildVerison;
/*!
 @method
 @abstract 当前设备信息获取方法
 @discussion 此方法可以获取设备基本信息的json格式字符串
 @result 返回值为json格式字符串
 */
- (NSString *)deviceInfo;

/**
 获取UDIDUDID

 @return 返回UDID
 */
+ (NSString *)LoadUDID;


@end
