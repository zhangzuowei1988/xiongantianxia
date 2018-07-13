//
//  ContentPicView.h
//  News
//
//  Created by pdmi on 2017/5/27.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ContentPicView : BaseView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *picCollectionView;
@property(nonatomic,strong)NSArray *picModelArrays;

@end
