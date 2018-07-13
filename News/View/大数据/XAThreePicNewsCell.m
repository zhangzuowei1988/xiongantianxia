//
//  XAThreePicNewsCell.m
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAThreePicNewsCell.h"
@interface XAThreePicNewsCell()
{
    NSMutableArray *picArray;
}
@end

@implementation XAThreePicNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
        self.titleLabel.frame = CGRectMake(15, 12, ScreenWidth-30, 44);
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.leftImageView.hidden = YES;
        self.statusLabel.frame = CGRectMake(18, 151, 28, 14);
        self.releaseFromLabel.frame = CGRectMake(56, 151, 200, 14);
        self.bottomLine.frame = CGRectMake(13, 179, ScreenWidth-26, 1);
        picArray = [[NSMutableArray alloc]init];
        [self addImageView];
    }
    return self;
}
- (void)addImageView
{
    CGFloat imageWidth = (ScreenWidth-40)/3;
    CGFloat imageHeight = imageWidth*3/4;

    for (int i=0;i<3;i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15+(imageWidth+5)*i, 70, imageWidth, imageHeight)];
        imageView.backgroundColor = UIColorFromRGB(0xf5f5f5);
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
        [picArray addObject:imageView];
    }
}
//普通新闻数据绑定

-(void)setNewsModel:(XANewsModel *)newsModel
{
    _newsModel = newsModel;
    if (_newsModel) {
        self.titleLabel.text = _newsModel.title;
        for (int i=0; i<3; i++) {
            NSString *picUrl =_newsModel.mCoverImgs[i];
            UIImageView *imageView =picArray[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[[CommData shareInstance] getPlaceHoldImage:self.leftImageView.size] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image.size.height>image.size.width){
                    imageView.contentMode = UIViewContentModeScaleAspectFit;
                } else  {
                    imageView.contentMode = UIViewContentModeScaleAspectFill;
                }
                
            }];
           // [imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[[CommData shareInstance] getPlaceHoldImage:imageView.size]];
        }
        //        CGSize labelSize = XA_MULTILINE_TEXTSIZE(_bigDataNewsModel.title, [UIFont systemFontOfSize:16], CGSizeMake(ScreenWidth-132, 1000), NSLineBreakByCharWrapping);
        //        if (labelSize.height<30) {//显示两行
        //            self.titleLabel.height = 22;
        //        } else {//显示一行
        //            self.titleLabel.height = 45;
        //        }
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
        for (UIImageView *imageView in picArray) {
            imageView.top = self.titleLabel.bottom+10;
        }
        self.statusLabel.top = _newsModel.cellHeight-29;
        self.releaseFromLabel.top = _newsModel.cellHeight-29;
        self.bottomLine.top = _newsModel.cellHeight-1;
    }
}
//大数据新闻数据绑定

-(void)setBigDataNewsModel:(XABigDataNewsModel *)bigDataNewsModel
{
    _bigDataNewsModel = bigDataNewsModel;
    if (_bigDataNewsModel) {
        self.titleLabel.text = _bigDataNewsModel.title;
        for (int i=0; i<3; i++) {
            NSString *picUrl =_bigDataNewsModel.picList[i];
            UIImageView *imageView =picArray[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[[CommData shareInstance] getPlaceHoldImage:self.leftImageView.size] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image.size.height>image.size.width){
                    imageView.contentMode = UIViewContentModeScaleAspectFit;
                } else  {
                    imageView.contentMode = UIViewContentModeScaleAspectFill;
                }
                
            }];
        }
//        CGSize labelSize = XA_MULTILINE_TEXTSIZE(_bigDataNewsModel.title, [UIFont systemFontOfSize:16], CGSizeMake(ScreenWidth-132, 1000), NSLineBreakByCharWrapping);
//        if (labelSize.height<30) {//显示两行
//            self.titleLabel.height = 22;
//        } else {//显示一行
//            self.titleLabel.height = 45;
//        }
//        if (_bigDataNewsModel.reason.length>0) {
//            self.statusLabel.text = _bigDataNewsModel.reason;
//            self.statusLabel.hidden = NO;
//            self.releaseFromLabel.left = 56;
//        } else {
            self.statusLabel.hidden = YES;
            self.releaseFromLabel.left = 18;
  //      }
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
        for (UIImageView *imageView in picArray) {
            imageView.top = self.titleLabel.bottom+10;
        }
        self.statusLabel.top = _bigDataNewsModel.cellHeight-29;
        self.releaseFromLabel.top = _bigDataNewsModel.cellHeight-29;
        self.bottomLine.top = _bigDataNewsModel.cellHeight-1;
    }
    
}
@end
