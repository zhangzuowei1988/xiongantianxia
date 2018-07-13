//
//  ContentVideoTitleCell.m
//  News
//
//  Created by pdmi on 2017/6/9.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "ContentVideoTitleCell.h"

@implementation ContentVideoTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.updownBtn setImage:[UIImage imageNamed:@"downBtn"] forState:UIControlStateNormal];
    [self.updownBtn setImage:[UIImage imageNamed:@"upBtn"] forState:UIControlStateSelected];
   
    
}
-(void)setCellChangeBig:(BOOL)changeBig withDic:(NSDictionary *)dic
{
    
    self.updownBtn.selected=changeBig;
    if (changeBig==YES) {
        self.descLabel.text=[dic objectForKey:@"summary"];

    }else{
        self.descLabel.text=@"";
    }
    self.titleLabel.text=[dic objectForKey:@"title"];
    self.publishTimeLabel.text=  [dic objectForKey:@"publishTime"];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)upDownBtnPressed:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    
    [self.delegate upDownBtnPressed:btn];
    
    }
@end
