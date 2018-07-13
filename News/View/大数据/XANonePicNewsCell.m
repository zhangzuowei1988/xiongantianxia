//
//  XANonePicNewsCell.m
//  News
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XANonePicNewsCell.h"

@implementation XANonePicNewsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
        self.titleLabel.frame = CGRectMake(15, 9, ScreenWidth-30, 22);
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.leftImageView.hidden = YES;
        self.statusLabel.frame = CGRectMake(18, 43, 28, 14);
        self.releaseFromLabel.frame = CGRectMake(56, 43, 200, 14);
        self.bottomLine.frame = CGRectMake(13, 71, ScreenWidth-26, 1);
    }
    return self;
}
//普通新闻列表
-(void)setNewsModel:(XANewsModel *)newsModel
{
    _newsModel = newsModel;
    if (_newsModel) {
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
        self.statusLabel.top = self.titleLabel.bottom+12;
        self.releaseFromLabel.top = self.titleLabel.bottom+12;
        self.bottomLine.top = self.titleLabel.bottom+40;
    }
}
//大数据
-(void)setBigDataNewsModel:(XABigDataNewsModel *)bigDataNewsModel
{
    _bigDataNewsModel = bigDataNewsModel;
    if (_bigDataNewsModel) {
        self.titleLabel.text = _bigDataNewsModel.title;
//        if (_bigDataNewsModel.reason.length>0) {
//            self.statusLabel.text = _bigDataNewsModel.reason;
//            self.statusLabel.hidden = NO;
//            self.releaseFromLabel.left = 56;
//        } else {
            self.statusLabel.hidden = YES;
            self.releaseFromLabel.left = 18;
//        }
        
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
        self.statusLabel.top = self.titleLabel.bottom+12;
        self.releaseFromLabel.top = self.titleLabel.bottom+12;
        self.bottomLine.top = self.titleLabel.bottom+40;
    }
    
}
//雄安发布
- (void)setPublishNewsModel:(XAPublishNewsModel *)publishNewsModel
{
    _publishNewsModel = publishNewsModel;
    if (_publishNewsModel) {
        self.titleLabel.text = _publishNewsModel.title;
//        if (_publishNewsModel.tag.length>0) {
//            self.statusLabel.text = _newsModel.tag;
//            self.statusLabel.hidden = NO;
//            self.releaseFromLabel.left = 56;
//        } else {
            self.statusLabel.hidden = YES;
            self.releaseFromLabel.left = 18;
//        }
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
        self.statusLabel.top = self.titleLabel.bottom+12;
        self.releaseFromLabel.top = self.titleLabel.bottom+12;
        self.bottomLine.top = self.titleLabel.bottom+40;

    }
}
@end
