//
//  MeCollectionAndOrderCell.h
//  News
//
//  Created by pdmi on 2017/7/3.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeCollectionAndOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIView *orderView;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@end
