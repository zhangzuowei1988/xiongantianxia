//
//  MeCollectionAndOrderCell.m
//  News
//
//  Created by pdmi on 2017/7/3.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "MeCollectionAndOrderCell.h"
#import "UIView+parentController.h"
#import "CollectionListController.h"
#import "MeCommentController.h"
#import "OrderRoomListController.h"
@implementation MeCollectionAndOrderCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewPressed)];
    [self.collectionView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentViewPressed)];
    [self.commentView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderViewPressed)];
    [self.orderView addGestureRecognizer:tap2];
    
    self.collectionLabel.font=[UIFont systemFontOfSize:SecondTitleFontSize*[CommData shareInstance].scale];
    self.commentLabel.font=[UIFont systemFontOfSize:SecondTitleFontSize*[CommData shareInstance].scale];
    self.orderLabel.font=[UIFont systemFontOfSize:SecondTitleFontSize*[CommData shareInstance].scale];
    
    self.collectionLabel.textColor=NewsBlcakColor;
    self.commentLabel.textColor=NewsBlcakColor;
    self.orderLabel.textColor=NewsBlcakColor;
    // Initialization code
}
-(void)collectionViewPressed{
    CollectionListController *collectionList=[[CollectionListController alloc]init];
    [[self parentController].navigationController pushViewController:collectionList animated:YES];
    
}
-(void)commentViewPressed{
    MeCommentController *collectionList=[[MeCommentController alloc]init];
    [[self parentController].navigationController pushViewController:collectionList animated:YES];
    
}
-(void)orderViewPressed{
    //OrderRoomListController
    OrderRoomListController *collectionList=[[OrderRoomListController alloc]init];
    [[self parentController].navigationController pushViewController:collectionList animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
