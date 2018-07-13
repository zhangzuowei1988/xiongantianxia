//
//  XABigDataLeftPicNewsCell.m
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XALeftPicNewsCell.h"

@interface XALeftPicNewsCell()
{
}
@end

@implementation XALeftPicNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self addContentView];
//        CGFloat imageWidth = (ScreenWidth-40)/3;
//        CGFloat imageHeight = imageWidth*3/4;
        self.leftImageView.frame = CGRectMake(13, 15, 93, 70);
        self.titleLabel.frame = CGRectMake(self.leftImageView.right+10, 15, ScreenWidth-132, 0);
        self.statusLabel.frame = CGRectMake(self.leftImageView.right+10, 71, 28, 14);
        self.releaseFromLabel.frame = CGRectMake(self.leftImageView.right+47, 71, 200, 14);
        self.bottomLine.frame = CGRectMake(13, 99, ScreenWidth-26, 1);
    }
    return self;
}
//普通新闻数据绑定

-(void)setNewsModel:(XANewsModel *)newsModel
{
    _newsModel = newsModel;
    if (_newsModel) {
        if (_newsModel.mCoverImgs.count>0) {
            __weak typeof(self) weakSelf = self;
            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.mCoverImgs.firstObject] placeholderImage:[[CommData shareInstance] getPlaceHoldImage:self.leftImageView.size] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image.size.height>image.size.width){
                    weakSelf.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
                } else  {
                    weakSelf.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
                }
                
            }];
//            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.mCoverImgs.firstObject] placeholderImage:[[CommData shareInstance] getPlaceHoldImage:self.leftImageView.size]];
        }
        self.titleLabel.text = _newsModel.title;
        CGSize labelSize = XA_MULTILINE_TEXTSIZE(_newsModel.title, [UIFont fontWithName:@"PingFangSC-Regular" size:16], CGSizeMake(ScreenWidth-132, 1000), NSLineBreakByCharWrapping);
        if (labelSize.height<30) {//显示一行ScreenWidth-self.leftImageView.right+26
            self.titleLabel.height = 22;
        } else {//显示两行
            self.titleLabel.height = 45;
        }
        if (_newsModel.tag.length>0) {
            self.statusLabel.text = _newsModel.tag;
            self.statusLabel.hidden = NO;
            self.releaseFromLabel.left = self.leftImageView.right+47;
        } else {
            self.statusLabel.hidden = YES;
            self.releaseFromLabel.left = self.leftImageView.right+13;
        }
        if (_newsModel.sourceName.length==0) {
            self.releaseFromLabel.text = [NSString
                                          stringWithFormat:@"%@%@",_newsModel.sourceName,
                                          _newsModel.publishTime];
            
        } else
            self.releaseFromLabel.text = [NSString
                                          stringWithFormat:@"%@  %@",_newsModel.sourceName,
                                          _newsModel.publishTime];
        self.bottomLine.top =_newsModel.cellHeight-1 ;
        self.statusLabel.top = _newsModel.cellHeight-29;
self.releaseFromLabel.top = _newsModel.cellHeight-29;
//        if (_bigDataNewsModel.is_clk) {
//            self.titleLabel.textColor =[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
//        }else {
//            self.titleLabel.textColor =[UIColor blackColor];
//        }
    }
}
//大数据新闻数据绑定

-(void)setBigDataNewsModel:(XABigDataNewsModel *)bigDataNewsModel
{
    _bigDataNewsModel = bigDataNewsModel;
    if (_bigDataNewsModel) {
        if (_bigDataNewsModel.picList.count>0) {
            __weak typeof(self) weakSelf = self;
            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_bigDataNewsModel.picList.firstObject] placeholderImage:[[CommData shareInstance] getPlaceHoldImage:self.leftImageView.size] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image.size.height>image.size.width){
                    weakSelf.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
                } else  {
                    weakSelf.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
                }
                
            }];
          //  [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_bigDataNewsModel.picList.firstObject] placeholderImage:[UIImage imageNamed:@"placeholder_image"]];
        }
        self.titleLabel.text = _bigDataNewsModel.title;
        CGSize labelSize = XA_MULTILINE_TEXTSIZE(_bigDataNewsModel.title, [UIFont fontWithName:@"PingFangSC-Regular" size:16], CGSizeMake(ScreenWidth-132, 1000), NSLineBreakByCharWrapping);
        if (labelSize.height<30) {//显示一行
            self.titleLabel.height = 22;
        } else {//显示两行
            self.titleLabel.height = 45;
        }
//        if (_bigDataNewsModel.reason.length>0) {
//            self.statusLabel.text = _bigDataNewsModel.reason;
//            self.statusLabel.hidden = NO;
//            self.releaseFromLabel.left = 150;
//        } else {
            self.statusLabel.hidden = YES;
            self.releaseFromLabel.left = 116;
    //    }
        if (_bigDataNewsModel.media.length==0) {
            self.releaseFromLabel.text = [NSString
                                          stringWithFormat:@"%@%@",_bigDataNewsModel.media,
                                          _bigDataNewsModel.createTimeStr];
            
        } else {
            self.releaseFromLabel.text = [NSString
                                          stringWithFormat:@"%@  %@",_bigDataNewsModel.media,
                                          _bigDataNewsModel.createTimeStr];
        }
        if (_bigDataNewsModel.is_clk) {
            self.titleLabel.textColor =[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
        }else {
            self.titleLabel.textColor =[UIColor blackColor];
        }
    }
}
//雄安发布新闻数据绑定

- (void)setPublishNewsModel:(XAPublishNewsModel *)publishNewsModel
{
    _publishNewsModel = publishNewsModel;
    if (_publishNewsModel) {
        if (_publishNewsModel.imageUrls.count>0) {
            __weak typeof(self) weakSelf = self;
            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_publishNewsModel.imageUrls.firstObject] placeholderImage:[[CommData shareInstance] getPlaceHoldImage:self.leftImageView.size] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image.size.height>image.size.width){
                    weakSelf.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
                } else  {
                    weakSelf.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
                }
                
            }];
        }
        self.titleLabel.text = _publishNewsModel.title;
        CGSize labelSize = XA_MULTILINE_TEXTSIZE(_publishNewsModel.title, [UIFont fontWithName:@"PingFangSC-Regular" size:16], CGSizeMake(ScreenWidth-132, 1000), NSLineBreakByCharWrapping);
        if (labelSize.height<30) {//显示一行ScreenWidth-self.leftImageView.right+26
            self.titleLabel.height = 22;
        } else {//显示两行
            self.titleLabel.height = 45;
        }
//        if (_newsModel.tag.length>0) {
//            self.statusLabel.text = _newsModel.tag;
//            self.statusLabel.hidden = NO;
//            self.releaseFromLabel.left = self.leftImageView.right+47;
//        } else {
            self.statusLabel.hidden = YES;
            self.releaseFromLabel.left = self.leftImageView.right+13;
  //      }
        if (_publishNewsModel.source.length==0) {
            self.releaseFromLabel.text = [NSString
                                          stringWithFormat:@"%@%@",_publishNewsModel.source,
                                          _publishNewsModel.publishTime];
            
        } else
            self.releaseFromLabel.text = [NSString
                                          stringWithFormat:@"%@  %@",_publishNewsModel.source,
                                          _publishNewsModel.publishTime];
        self.bottomLine.top =_publishNewsModel.cellHeight-1 ;
        self.statusLabel.top = _publishNewsModel.cellHeight-29;
        self.releaseFromLabel.top = _publishNewsModel.cellHeight-29;
    }
}
@end
