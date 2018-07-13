//
//  ContentViedoCell.h
//  News
//
//  Created by pdmi on 2017/6/8.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBPlayer.h"
//#import "ContentArticleModel.h"
@interface ContentViedoCell : BaseTableCell
//@property (nonatomic,strong) SBPlayer *player;
@property (weak, nonatomic) IBOutlet SBPlayer *player;

-(void)initDic:(NSDictionary *)videoDic;
//-(void)initWithModel:(ContentArticleModel *)model;
@end
