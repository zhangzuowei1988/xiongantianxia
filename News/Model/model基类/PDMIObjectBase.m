//
//  SSObjectBase.m
//  WiFi104
//
//  Created by Steven on 13-12-6.
//  Copyright (c) 2013年 Neva. All rights reserved.
//

#import "PDMIObjectBase.h"
#import "objc/runtime.h"

@implementation PDMIObjectBase

- (instancetype)init{
    
    if (self=[super init]) {
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        
        @try {
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                NSString *key=[[NSString alloc] initWithCString:property_getName(property)
                                                       encoding:NSUTF8StringEncoding];
                id value = [aDecoder decodeObjectForKey:key];
                [self setValue:value forKey:key];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Exception: %@", exception);
            return nil;
        }
        @finally {
            
        }
        
        free(properties);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        NSString *key=[[NSString alloc] initWithCString:property_getName(property)
                                               encoding:NSUTF8StringEncoding];
        
        id value=[self valueForKey:key];
        if (value && key) {
            if ([value isKindOfClass:[NSObject class]]) {
                [aCoder encodeObject:value forKey:key];
            } else {
                NSNumber * v = [NSNumber numberWithInt:(int)value];
                [aCoder encodeObject:v forKey:key];
            }
        }
    }
    free(properties);
    properties = NULL;
    
    
}

-(id)checkValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return checkNull(value);
    }else{
        return value;
    }
}
@end
