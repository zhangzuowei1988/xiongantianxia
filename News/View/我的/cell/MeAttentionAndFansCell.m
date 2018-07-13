//
//  MeAttentionAndFansCell.m
//  News
//
//  Created by pdmi on 2017/7/3.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "MeAttentionAndFansCell.h"
#import "AttentionAndFansController.h"
#import "UIView+parentController.h"

@implementation MeAttentionAndFansCell

- (void)awakeFromNib {
    
     [super awakeFromNib];
     [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attentionViewPressed)];
    [self.attentionView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fansViewPressed)];
    [self.fansView addGestureRecognizer:tap1];
    
    self.attentionLabel.font=[UIFont systemFontOfSize:SecondTitleFontSize*[CommData shareInstance].scale];
    self.fansLabel.font=[UIFont systemFontOfSize:SecondTitleFontSize*[CommData shareInstance].scale];
    self.attentionLabel.textColor=NewsBlcakColor;
    self.fansLabel.textColor=NewsBlcakColor;
   
    
    // Initialization code
}
-(void)attentionViewPressed{
    AttentionAndFansController *controller=[[AttentionAndFansController alloc]init];
    controller.type=1;
    [[self parentController].navigationController pushViewController:controller animated:YES];
}
-(void)fansViewPressed{
    AttentionAndFansController *controller=[[AttentionAndFansController alloc]init];
    controller.type=2;
    [[self parentController].navigationController pushViewController:controller animated:YES];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
