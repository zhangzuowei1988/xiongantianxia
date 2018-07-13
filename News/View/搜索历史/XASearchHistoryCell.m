//
//  XASearchHistoryCell.m
//  News
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XASearchHistoryCell.h"

@implementation XASearchHistoryCell

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
    UIImageView *searchImageView = [[UIImageView alloc]init];
    searchImageView.image = [UIImage imageNamed:@"search_image"];
    searchImageView.frame = CGRectMake(24, 14, 16, 15);
    [self.contentView addSubview:searchImageView];
    
    _searchTextLabel = [[UILabel alloc] init];
    _searchTextLabel.frame = CGRectMake(51, 9, ScreenWidth-51, 22);
    _searchTextLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    _searchTextLabel.textColor = [UIColor colorWithRed:255/255.0 green:77/255.0 blue:77/255.0 alpha:1/1.0];
    [self.contentView addSubview:_searchTextLabel];
}
@end
