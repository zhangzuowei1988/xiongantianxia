//
//  ContentPicCell.m
//  News
//
//  Created by pdmi on 2017/5/27.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "ContentPicCell.h"

@interface ContentPicCell ()
{
    UILabel *descriptionLabel;
    UIView *descriptionView;
    UILabel *indexLabel;
}
@end
@implementation ContentPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
   // int32_t rgbValue = rand();
  // self.zoomView.imageView.backgroundColor = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];

      // Initialization code
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zoomView=[[ContentPicZoomView alloc] initWithFrame:self.bounds];
        [self addSubview:self.zoomView];
        self.backgroundColor=NewsBlcakColor;
        //int32_t rgbValue = rand();
       // self.zoomView.imageView.backgroundColor = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
        descriptionView = [[UIView alloc]initWithFrame:CGRectMake(16, self.height-200, ScreenWidth-32, 100)];
        descriptionView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:descriptionView];
        
        indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,30,22)];
        indexLabel.backgroundColor = [UIColor clearColor];
        indexLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
        indexLabel.textColor = [UIColor colorWithRed:255/255.0 green:77/255.0 blue:77/255.0 alpha:1/1.0];
        [descriptionView addSubview:indexLabel];
        
        descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, ScreenWidth-32, 100)];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        descriptionLabel.lineBreakMode = NSLineBreakByCharWrapping;
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.textColor = [UIColor whiteColor];
        [descriptionView addSubview:descriptionLabel];
    }
    return self;
}
- (void)setPicListModel:(XAPicListModel *)picListModel
{
    _picListModel = picListModel;
    [self.zoomView resetViewFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.zoomView uddateImageWithUrl:_picListModel.imgPath];
    indexLabel.text = _currentPic;
    descriptionLabel.text = [NSString stringWithFormat:@"        %@",_picListModel.pDescription];
    CGSize labelSize = XA_MULTILINE_TEXTSIZE(descriptionLabel.text, [UIFont fontWithName:@"PingFangSC-Semibold" size:14], CGSizeMake(ScreenWidth-32, 1000), NSLineBreakByCharWrapping);
    descriptionLabel.height = labelSize.height;
    descriptionView.height = labelSize.height;
    descriptionView.top = self.height-descriptionView.height-50;
    [self.contentView bringSubviewToFront:descriptionView];
}
-(void)setImageUrl:(NSString *)url
{
    [self.zoomView resetViewFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.zoomView uddateImageWithUrl:url];
}
@end
