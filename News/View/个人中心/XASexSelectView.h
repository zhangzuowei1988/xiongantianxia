//
//  XASexSelectView.h
//  News
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XASexSelectViewDelegate <NSObject>

-(void)sexSelectButtonClick:(NSInteger)index;

@end

@interface XASexSelectView : BaseView
@property(nonatomic,assign)id <XASexSelectViewDelegate> delegate;
@property(nonatomic,strong) NSString *sex;
@property (nonatomic, copy) void (^block)(NSString *);

@end
