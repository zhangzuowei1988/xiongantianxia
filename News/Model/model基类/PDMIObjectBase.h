//
//  SSObjectBase.h
//  WiFi104
//
//  Created by Steven on 13-12-6.
//  Copyright (c) 2013年 Neva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDMIObjectBase : NSObject <NSCoding>


/**
 判断value是否为空

 @param value 需要判断的值
 @return 如果为空返回nil，否则返回value
 */
-(id)checkValue:(id)value;
@end
