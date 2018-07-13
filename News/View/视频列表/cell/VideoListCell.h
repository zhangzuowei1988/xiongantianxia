//
//  VideoListCell.h
//  News
//
//  Created by pdmi on 2017/6/14.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SBPlayer.h"
#import "NewsListModel.h"
#import "TagViewWithLogo.h"
@protocol VideoListCellDelegate

-(void)videoPlayWithIndexPath:(NSIndexPath *)path;
-(void)videoStopWithIndexPath:(NSIndexPath *)path;
-(void)videoPauseWithIndexPath:(NSIndexPath *)path;
-(void)commentBtnPressedWithIndexPath:(NSIndexPath *)path;

@end
@interface VideoListCell : BaseTableCell<SBPlayerDelegate,TagViewWithLogoDelegate>
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<VideoListCellDelegate>delegate;
//@property (weak, nonatomic) IBOutlet UIImageView *LogoImageView;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;
//@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet SBPlayer *player;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerHeight;
@property (weak, nonatomic) IBOutlet TagViewWithLogo *tagView;

-(void)initDic:(NewsListModel *)model;
- (IBAction)CommentBtnPressed:(id)sender;

@end
