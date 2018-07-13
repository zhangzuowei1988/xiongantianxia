//
//  XAGoverAffairsCell.m
//  News
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAGoverAffairsCell.h"

@interface XAGoverAffairsCell()
{
    UILabel *affairsContentLabel;
    UILabel *affairsSourceLabel;
    UILabel *affairsTimeLabel;
    UIView *lineView;
}
@end

@implementation XAGoverAffairsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}
- (void)addContentView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    affairsContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 12, ScreenWidth-32, 44)];
    affairsContentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    affairsContentLabel.numberOfLines = 0;
    affairsContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    affairsContentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:affairsContentLabel];
    
    affairsSourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 70, ScreenWidth/2.0+50, 20)];
    affairsSourceLabel.textColor =  [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
    affairsSourceLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.contentView addSubview:affairsSourceLabel];
    
    affairsTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-16, 70, ScreenWidth/2.0, 20)];
    affairsTimeLabel.textColor =  [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
    affairsTimeLabel.textAlignment = NSTextAlignmentRight;
    affairsTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.contentView addSubview:affairsTimeLabel];
    
    lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 103, ScreenWidth, 1);
    lineView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [self.contentView addSubview:lineView];
}

-(void)setGoverAffairsModel:(XAGoverAffairsModel *)goverAffairsModel
{
    _goverAffairsModel = goverAffairsModel;
    if (_goverAffairsModel) {
        CGSize labelSize = XA_MULTILINE_TEXTSIZE(_goverAffairsModel.affairsContent, affairsContentLabel.font, CGSizeMake(ScreenWidth-32, 1000), NSLineBreakByCharWrapping);
        if (labelSize.height<30) {//显示一行
            affairsContentLabel.height = 22;
        } else {//显示两行
            affairsContentLabel.height = 50;
        }
        affairsContentLabel.text = _goverAffairsModel.affairsContent;

        affairsSourceLabel.text = _goverAffairsModel.affairsSource;
        affairsTimeLabel.text = _goverAffairsModel.affairsTime;
        affairsTimeLabel.top = _goverAffairsModel.cellHeight - 25;
        affairsSourceLabel.top = _goverAffairsModel.cellHeight - 25;
        lineView.top =_goverAffairsModel.cellHeight-1;
    }
}
@end
