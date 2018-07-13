//
//  UIView+parentController.m
//  News
//
//  Created by pdmi on 2017/5/25.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "UIView+parentController.h"

@implementation UIView (parentController)
- (UIViewController *)parentController

{
    
    UIResponder *responder = [self nextResponder];    while (responder)
        
    {
        
        if ([responder isKindOfClass:[UIViewController class]])
            
        {
            
            return (UIViewController *)responder;
            
        }
        
        responder = [responder nextResponder];
        
    }
    
    return nil;
    
}


@end
