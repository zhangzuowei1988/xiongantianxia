//
//  ContentViedoCell.m
//  News
//
//  Created by pdmi on 2017/6/8.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "ContentViedoCell.h"

@implementation ContentViedoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //初始化播放器
    self.player = [[SBPlayer alloc]initWithUrl:[NSURL URLWithString:@"http://download.3g.joy.cn/video/236/60236937/1451280942752_hd.mp4"]];
    //设置标题
    [self.player setTitle:@""];
    //设置播放器背景颜色
    self.player.backgroundColor = [UIColor blackColor];
    //设置播放器填充模式 默认SBLayerVideoGravityResizeAspectFill，可以不添加此语句
    self.player.mode = SBLayerVideoGravityResizeAspectFill;
    //添加播放器到视图
    [self addSubview:self.player];
    //约束，也可以使用Frame
    
    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self);
        make.top.equalTo(self).with.offset(0);
       // make.height.mas_equalTo(@150);
         make.bottom.equalTo(self).with.offset(0);
    }];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end