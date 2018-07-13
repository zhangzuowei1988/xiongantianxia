//
//  VideoListCell.m
//  News
//
//  Created by pdmi on 2017/6/14.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "VideoListCell.h"
#import "UIImageView+WebCache.h"
@implementation VideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//  self.LogoImageView.layer.cornerRadius=20;
//  self.LogoImageView.clipsToBounds=YES;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
       self.player.controlView.hidden=YES;
    self.player.delegate=self;
    //设置播放器背景颜色
    self.player.backgroundColor = [UIColor blackColor];
    //设置播放器填充模式 默认SBLayerVideoGravityResizeAspectFill，可以不添加此语句
    self.player.mode = SBLayerVideoGravityResizeAspectFill;
    
    //添加播放器到视图
   // [self addSubview:self.player];
    //约束，也可以使用Frame
    
//    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.mas_equalTo(self);
//        make.top.equalTo(self).with.offset(0);
//        // make.height.mas_equalTo(@150);
//        make.bottom.equalTo(self).with.offset(0);
//    }];
    
    // Initialization code
    self.playerHeight.constant= self.playerHeight.constant*[CommData shareInstance].scale;
    self.tagView.delegate=self;
}

-(void)setCellStyle
{
    self.tagView.nameLabel.font=[UIFont systemFontOfSize:[CommData shareInstance].scale*ThirdTitleFontSize];
   self.tagView.nameLabel.textColor=[CommData shareInstance].commonBlackColor;
    
   self.tagView.playNumLabel.font=[UIFont systemFontOfSize:[CommData shareInstance].scale*ThirdTitleFontSize];
    self.tagView.playNumLabel.textColor=[CommData shareInstance].commonGrayColor;
    
    self.player.titleLabel.font=[UIFont systemFontOfSize:[CommData shareInstance].scale*FirstTitleFontSize];
    self.player.titleLabel.textColor=NewsWhiteColor;
    self.backgroundColor=[CommData shareInstance].commonBottomViewColor;
  
    
}
-(void)initDic:(NewsListModel *)model
{
    [self setCellStyle];
    NewsPublishModel *publishModel=model.publish;
    
    [self.player assetWithURL:[NSURL URLWithString:model.videoLink]];
    self.player.title=model.title;
    self.player.thumbImageStr=model.videoThumb;
    [self.tagView.logoImageView sd_setImageWithURL:[NSURL URLWithString:publishModel.avatar] placeholderImage:[CommData shareInstance].placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    self.tagView.nameLabel.text=publishModel.name;
   

}


-(void)commentBtnPressed
{
    [self.delegate commentBtnPressedWithIndexPath:self.indexPath];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)videoPlay
{
    [self.delegate videoPlayWithIndexPath:self.indexPath];
}
-(void)videoPause
{
    [self.delegate videoPauseWithIndexPath:self.indexPath];
}
-(void)videoStop
{
    [self.delegate videoStopWithIndexPath:self.indexPath];
}
@end
