//
//  NewsVideoTableView.m
//  News
//
//  Created by pdmi on 2017/6/14.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "NewsVideoTableView.h"


#import "ContentVideoView.h"
#import "NewsVideoContentController.h"

#import "PDMIJSON.h"
#import "VideoListCell.h"
static NSString *video_cell=@"VideoListCell";



@interface NewsVideoTableView()<VideoListCellDelegate>{
    
}
@property(nonatomic,strong)VideoListCell *playCell;
@end

@implementation NewsVideoTableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        self.tableView=[[NewsBaseTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped ];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self registerCell];
//        NSString *jsonStr=[[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"videoList" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
//        self.contentDic=[jsonStr JSONObject];
        
        
        
        [self addSubview:self.tableView];
        //self.tableView.backgroundColor=[UIColor redColor];
    }
    return self;
}
-(void)reloaData
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}
-(void)registerCell{
    
    [self.tableView registerNib:[UINib nibWithNibName:video_cell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:video_cell];
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)] ;
    headerView.backgroundColor=[UIColor whiteColor];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)] ;
    footerView.backgroundColor=[CommData shareInstance].commonGroundViewColor;
    return footerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return [self.listArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //NSDictionary *articleDic=[self.contentDic objectForKey:@"article"];
    
    VideoListCell *cell=(VideoListCell*)[tableView dequeueReusableCellWithIdentifier:video_cell];
    cell.indexPath=indexPath;
    cell.delegate=self;
    [cell initDic:[self.listArr objectAtIndex:indexPath.section]];
    return cell;
            
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self commentBtnPressedWithIndexPath:indexPath];
    
}


#pragma mark - videoListDeleggate
-(void)videoStopWithIndexPath:(NSIndexPath *)path{
    
}
-(void)videoPauseWithIndexPath:(NSIndexPath *)path{
    
}
-(void)videoPlayWithIndexPath:(NSIndexPath *)path{
    
    if (path!=[self.tableView indexPathForCell:self.playCell]) {
        [self.playCell.player pause];
        self.playCell.player.pauseOrPlayView.hidden=NO;
        self.playCell.player.pauseOrPlayView.imageBtn.selected=NO;
        [self.playCell.player.pauseOrPlayView.thumbImageView setHidden:NO];
        self.playCell.player.controlView.hidden=YES;
        
        self.playCell=[self.tableView cellForRowAtIndexPath:path];
        
    }
    
   
}
-(void)commentBtnPressedWithIndexPath:(NSIndexPath *)path{
    NewsVideoContentController *videoController=[[NewsVideoContentController alloc] init];
    [[self parentController].navigationController pushViewController:videoController animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *visibleCell=[self.tableView visibleCells];
    
   
    if (self.playCell!=nil) {
      __block  BOOL playCellVisible=NO;
        [visibleCell enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj==self.playCell) {
                playCellVisible=YES;
                
            }
        }];
        if (playCellVisible==NO) {
            [self.playCell.player pause];
            
            self.playCell.player.controlView.hidden=YES;
            self.playCell.player.pauseOrPlayView.hidden=NO;
            [self.playCell.player.pauseOrPlayView.thumbImageView setHidden:NO];
            
            NSLog(@"消失了");
        }

}
}
-(void)dealloc{
    
  
}
-(void)viewWillDissmiss
{
    if (self.playCell!=nil) {
        [self.playCell.player pause];
         self.playCell.player.pauseOrPlayView.imageBtn.selected=NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
