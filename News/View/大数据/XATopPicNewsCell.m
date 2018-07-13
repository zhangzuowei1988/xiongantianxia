//
//  XATopPicNewsCell.m
//  News
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XATopPicNewsCell.h"

@implementation XATopPicNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self addContentView];
        self.leftImageView.frame = CGRectMake(13, 15, ScreenWidth-30, (ScreenWidth-30)*0.75);
        self.titleLabel.frame = CGRectMake(15, 10, ScreenWidth-30, 0);
        self.statusLabel.frame = CGRectMake(18, 71, 28, 14);
        self.releaseFromLabel.frame = CGRectMake(56, 71, 200, 14);
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

       //     [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.mCoverImgs.firstObject] placeholderImage:nil];
        }
        self.titleLabel.text = _newsModel.title;
        if (_newsModel.tag.length>0) {
            self.statusLabel.text = _newsModel.tag;
            self.statusLabel.hidden = NO;
            self.releaseFromLabel.left = 56;
        } else {
            self.statusLabel.hidden = YES;
            self.releaseFromLabel.left = 18;
        }
        if (_newsModel.sourceName.length==0) {
            self.releaseFromLabel.text = [NSString
                                          stringWithFormat:@"%@%@",_newsModel.sourceName,
                                          _newsModel.publishTime];
            
        } else
            self.releaseFromLabel.text = [NSString
                                          stringWithFormat:@"%@  %@",_newsModel.sourceName,
                                          _newsModel.publishTime];
//        if (_bigDataNewsModel.is_clk) {
//            self.titleLabel.textColor =[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
//        }else {
//            self.titleLabel.textColor =[UIColor blackColor];
//        }
        self.titleLabel.height = _newsModel.titleLabelHeight;
        self.leftImageView.top = self.titleLabel.bottom+6;
        self.statusLabel.top = _newsModel.cellHeight-29;
        self.releaseFromLabel.top = _newsModel.cellHeight-29;
        self.bottomLine.top = _newsModel.cellHeight-1;
        if (_newsModel.contentType == 3) {//专题
            self.specialSubjectLabel.top =self.leftImageView.top+10;
            self.specialSubjectLabel.left =self.leftImageView.left+7;
            self.specialSubjectLabel.hidden = NO;
        } else {
            self.specialSubjectLabel.hidden = YES;
        }
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
           // [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_bigDataNewsModel.picList.firstObject] placeholderImage:nil];
        }
        self.titleLabel.text = _bigDataNewsModel.title;
//        if (_bigDataNewsModel.reason.length>0) {
//            self.statusLabel.text = _bigDataNewsModel.reason;
//            self.statusLabel.hidden = NO;
//            self.releaseFromLabel.left = 56;
//        } else {
            self.statusLabel.hidden = YES;
            self.releaseFromLabel.left = 18;
 //       }
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
        self.titleLabel.height = _bigDataNewsModel.titleLabelHeight;
        self.leftImageView.top = self.titleLabel.bottom+6;
        self.statusLabel.top = _bigDataNewsModel.cellHeight-29;
        self.releaseFromLabel.top = _bigDataNewsModel.cellHeight-29;
        self.bottomLine.top = _bigDataNewsModel.cellHeight-1;
    }
    
}
//雄安发布新闻数据绑定
-(void)setPublishNewsModel:(XAPublishNewsModel *)publishNewsModel
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
        
        //     [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.mCoverImgs.firstObject] placeholderImage:nil];
    }
    self.titleLabel.text = _publishNewsModel.title;
//    if (_newsModel.tag.length>0) {
//        self.statusLabel.text = _newsModel.tag;
//        self.statusLabel.hidden = NO;
//        self.releaseFromLabel.left = 56;
//    } else {
        self.statusLabel.hidden = YES;
        self.releaseFromLabel.left = 18;
//    }
    if (_publishNewsModel.source.length==0) {
        self.releaseFromLabel.text = [NSString
                                      stringWithFormat:@"%@%@",_publishNewsModel.source,
                                      _publishNewsModel.publishTime];
        
    } else
        self.releaseFromLabel.text = [NSString
                                      stringWithFormat:@"%@  %@",_publishNewsModel.source,
                                      _publishNewsModel.publishTime];
    //        if (_bigDataNewsModel.is_clk) {
    //            self.titleLabel.textColor =[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
    //        }else {
    //            self.titleLabel.textColor =[UIColor blackColor];
    //        }
    self.titleLabel.height = _publishNewsModel.titleLabelHeight;
    self.leftImageView.top = self.titleLabel.bottom+6;
    self.statusLabel.top = _publishNewsModel.cellHeight-29;
    self.releaseFromLabel.top = _publishNewsModel.cellHeight-29;
    self.bottomLine.top = _publishNewsModel.cellHeight-1;
    }
}
@end
