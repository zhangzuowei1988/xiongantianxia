//
//  ContentPicCell.h
//  News
//
//  Created by pdmi on 2017/5/27.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentPicZoomView.h"
#import "XAPicListModel.h"
@interface ContentPicCell : BaseCollectionCell

@property (strong, nonatomic)  ContentPicZoomView *zoomView;
-(void)setImageUrl:(NSString *)url;
@property(nonatomic,strong)XAPicListModel *picListModel;
@property(nonatomic,strong)NSString *currentPic;

@end
