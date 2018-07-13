//
//  XAPhotoSelectView.h
//  News
//
//  Created by mac on 2018/5/9.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XAPhotoSelectViewDelegate <NSObject>

/**
 按钮点击代理

 @param index 按钮的index
 */
-(void)photoSelectButtonClick:(NSInteger)index;

@end
@interface XAPhotoSelectView : BaseView

@property(nonatomic,assign)id <XAPhotoSelectViewDelegate> delegate;
@property(nonatomic,copy)void (^block)(UIImagePickerControllerSourceType);
@end
