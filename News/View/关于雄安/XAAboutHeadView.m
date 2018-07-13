//
//  XAAboutHeadView.m
//  News
//
//  Created by mac on 2018/4/25.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAAboutHeadView.h"
#import "H5NewsDetailController.h"
#import "H5XADetailViewController.h"

@interface XAAboutHeadView ()
{
    UIImageView *topImageView;
}
@end

@implementation XAAboutHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    return self;
}
- (void)addContentView
{
    topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*197/375)];
    //    topImageView.contentMode = UIViewContentModeScaleAspectFit;
    topImageView.image = [UIImage imageNamed:@"about_xiongan_header"];
    //  [topImageView sd_setImageWithURL:[NSURL URLWithString:@""]];
    [self addSubview:topImageView];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, topImageView.bottom, ScreenWidth, 32)];
    grayView.backgroundColor = UIColorFromRGB(0xefefef);
    [self addSubview:grayView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(18, 0, 28, 32);
    titleLabel.text = @"雄安";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    [grayView addSubview:titleLabel];
    
    NSArray *buttonImages = @[@"introduce",@"government",@"leaders"];
    NSArray *buttonTitles = @[@"雄安介绍",@"政府机构",@"领导班子"];
    CGFloat buttonSpace = (ScreenWidth-180)/4;
    for (int i = 0; i<buttonImages.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonSpace+i*(buttonSpace+60), grayView.bottom+15, 60, 70);
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:buttonImages[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(-12 ,7, 12, -7);
        button.titleEdgeInsets = UIEdgeInsetsMake(button.frame.size.height-button.imageView.frame.size.height-button.imageView.frame.origin.y+22, -button.imageView.frame.size.width, 0, 0);
        button.tag = i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, grayView.bottom+104, ScreenWidth, 1)];
    bottomLineView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [self addSubview:bottomLineView];
}
- (void)buttonClicked:(UIButton*)button
{
    if (button.tag==0) {//雄安介绍
        H5XADetailViewController *detail = [[H5XADetailViewController alloc]init];
        detail.url = self.introduceUrl;
     //   detail.myTitle = @"雄安介绍";
        detail.shareTitle =@"雄安介绍";
        [[self parentController].navigationController pushViewController:detail animated:YES];
    } else if (button.tag==1){//政府机构
        H5XADetailViewController *detail = [[H5XADetailViewController alloc]init];
        detail.url = self.organsUrl;
        detail.myTitle = @"政府机构";
        detail.shareTitle =@"政府机构";
        [[self parentController].navigationController pushViewController:detail animated:YES];
    } else if (button.tag == 2){//领导班子
        H5XADetailViewController *detail = [[H5XADetailViewController alloc]init];
        detail.url = self.leaderUrl;
        detail.myTitle = @"领导班子";
        detail.shareTitle =@"领导班子";
        [[self parentController].navigationController pushViewController:detail animated:YES];
    }
    [self parentController];
}
- (void)setTopImageUrl:(NSString *)topImageUrl
{
    _topImageUrl = topImageUrl;
    if (_topImageUrl) {
        [topImageView sd_setImageWithURL:[NSURL URLWithString:_topImageUrl] placeholderImage:[UIImage imageNamed:@"about_xiongan_header"]];
    }
}
@end
