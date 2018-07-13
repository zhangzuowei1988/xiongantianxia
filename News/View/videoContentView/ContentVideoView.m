//
//  ContentVideoView.m
//  News
//
//  Created by pdmi on 2017/6/8.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "ContentVideoView.h"

#import "PDMIJSON.h"
#import "ContentHeaderView.h"


#import "ContentAuthorCell.h"
#import "ContentOrderCell.h"

#import "TitleTopPicCell.h"

#import "PicLeftCell.h"

#import "CommentCell.h"

#import  "SBPlayer.h"

#import "ContentViedoCell.h"
#import "ContentVideoTitleCell.h"
static NSString *contentHeader_View=@"ContentHeaderView";
static NSString *picLeftCell=@"PicLeftCell";
static NSString *comment_cell=@"CommentCell";

static NSString *contentAuthor_cell=@"ContentAuthorCell";
static NSString *contentOrder_cell=@"ContentOrderCell";
static NSString *titleTopPic_cell=@"TitleTopPicCell";
static NSString *video_cell=@"ContentViedoCell";

static NSString *video_titleCell=@"ContentVideoTitleCell";

@interface ContentVideoView()<ContentVideoCellDelegate>{
    BOOL cellBig;
}

@end

@implementation ContentVideoView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped ];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
       [self registerCell];
        NSString *jsonStr=[[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"content" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        self.contentDic=[jsonStr JSONObject];
        
      
        [self initStructArr];
        [self addSubview:self.tableView];
        //self.tableView.backgroundColor=[UIColor redColor];
    }
    return self;
}
-(void)initStructArr{
    self.structArr=[[NSMutableArray alloc] init];
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc] init];
    [dic1 setObject:@"视频" forKey:@"sectionTitle"];
    [dic1 setObject:@"3" forKey:@"rowsCount"];
    
    NSMutableDictionary *dic2=[[NSMutableDictionary alloc] init];
    [dic2 setObject:@"广告" forKey:@"sectionTitle"];
    [dic2 setObject:[NSString stringWithFormat:@"%d",[self.contentDic objectForKey:@"ad"]==nil||[self.contentDic objectForKey:@"ad"]==[NSNull null]? 0:1] forKey:@"rowsCount"];
    // [dic2 setObject:@"0" forKey:@"rowsCount"];
    
    
    NSMutableDictionary *dic3=[[NSMutableDictionary alloc] init];
    [dic3 setObject:@"推荐阅读" forKey:@"sectionTitle"];
    [dic3 setObject:[NSString stringWithFormat:@"%lu",[[self.contentDic objectForKey:@"relative"]count]] forKey:@"rowsCount"];
    //[dic3 setObject:@"0" forKey:@"rowsCount"];
    
    NSMutableDictionary *dic4=[[NSMutableDictionary alloc] init];
    [dic4 setObject:@"热门评论" forKey:@"sectionTitle"];
    [dic4 setObject:[NSString stringWithFormat:@"%lu",[[self.contentDic objectForKey:@"comment"]count]] forKey:@"rowsCount"];
    //[dic4 setObject:@"0" forKey:@"rowsCount"];
    [self.structArr addObject:dic1];
    [self.structArr addObject:dic2];
    [self.structArr addObject:dic3];
    [self.structArr addObject:dic4];
    
}
-(void)registerCell{
    
    [self.tableView registerNib:[UINib nibWithNibName:contentHeader_View bundle:[NSBundle mainBundle]] forCellReuseIdentifier:contentHeader_View];
    [self.tableView registerNib:[UINib nibWithNibName:video_titleCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:video_titleCell];
    [self.tableView registerNib:[UINib nibWithNibName:video_cell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:video_cell];
    [self.tableView registerNib:[UINib nibWithNibName:contentAuthor_cell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:contentAuthor_cell];
    [self.tableView registerNib:[UINib nibWithNibName:contentOrder_cell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:contentOrder_cell];
    [self.tableView registerNib:[UINib nibWithNibName:picLeftCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:picLeftCell];
    [self.tableView registerNib:[UINib nibWithNibName:comment_cell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:comment_cell];
    [self.tableView registerNib:[UINib nibWithNibName:titleTopPic_cell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:titleTopPic_cell];
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSDictionary *dic=[self.structArr objectAtIndex:section];
    ContentHeaderView *headerView=(ContentHeaderView *)[tableView dequeueReusableCellWithIdentifier:contentHeader_View];
    if (section==0||section==1) {
        return nil;
    }else{
        headerView.titleLabel.text=[dic objectForKey:@"sectionTitle"];
        if ([[dic objectForKey:@"rowsCount"] integerValue]==0) {
            return nil;
        }else{
            return headerView;
            
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic=[self.structArr objectAtIndex:section];
    if (section==0||section==1) {
        return CGFLOAT_MIN;
    }else {
        if ([[dic objectForKey:@"rowsCount"] integerValue]==0) {
            return CGFLOAT_MIN;
        }else{
            return 40;
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic=[self.structArr objectAtIndex:section];
    if (section==0) {
        return 3;
    }else{
        return  [[dic objectForKey:@"rowsCount"] integerValue];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        
        return 180;
    }else{
        return UITableViewAutomaticDimension;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 显示顺序  视频内容（必显示，其他三项判断显示）  广告   推荐阅读   评论
    NSInteger num=1;
    if ([[self.contentDic objectForKey:@"ad"] count]>0) {
        num++;
    }
    if ([[self.contentDic objectForKey:@"relative"] count]>0) {
        num++;
    }
    if ([[self.contentDic objectForKey:@"comment"] count]>0) {
        num++;
    }
    
    
    return num;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) { //video
        NSDictionary *articleDic=[self.contentDic objectForKey:@"article"];
        if (indexPath.row==0) {
            ContentViedoCell *cell=(ContentViedoCell*)[tableView dequeueReusableCellWithIdentifier:video_cell];
           // [cell initDic:articleDic];
            return cell;
            
            
        }else if (indexPath.row==1){
           ContentVideoTitleCell *cell=(ContentVideoTitleCell*)[tableView dequeueReusableCellWithIdentifier:video_titleCell];
            cell.delegate=self;
            if (cellBig==NO) {
                
                [cell setCellChangeBig:NO withDic:articleDic];
            }else{
                [cell setCellChangeBig:YES withDic:articleDic];
                
            }
            // [cell initDic:articleDic];
            return cell;
            
        }else if (indexPath.row==2){
            if ([articleDic objectForKey:@"subscribe"]==nil||[articleDic objectForKey:@"subscribe"]==[NSNull null]) {
                ContentAuthorCell *cell=(ContentAuthorCell*)[tableView dequeueReusableCellWithIdentifier:contentAuthor_cell];
                [cell initDic:articleDic];
                return cell;
                
            }else{
                ContentOrderCell *cell=(ContentOrderCell *)[tableView dequeueReusableCellWithIdentifier:contentOrder_cell];
                [cell initDic:articleDic];
                return cell;
            }

        }
        
        
    }else if (indexPath.section==1){
        NSDictionary *adDic=[self.contentDic objectForKey:@"ad"];
        
        TitleTopPicCell *cell=(TitleTopPicCell*) [tableView dequeueReusableCellWithIdentifier:titleTopPic_cell];
        cell.titleLabel.text=[adDic objectForKey:@"title"];
        [cell setCommentLabelHidden];
        cell.tagLabel.hidden=NO;
        cell.tagLabel.text=@"广告";
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:[adDic objectForKey:@"logoFile"]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        return cell;
    }else if (indexPath.section==2){
        NSDictionary *relativeDic=[[self.contentDic objectForKey:@"relative"] objectAtIndex:indexPath.row];
        PicLeftCell *cell=(PicLeftCell*) [tableView dequeueReusableCellWithIdentifier:picLeftCell];
        cell.titleLabel.text=[relativeDic objectForKey:@"title"];
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:[relativeDic objectForKey:@"logoFile"]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        
        
        return cell;
    }else if (indexPath.section==3){
        NSDictionary *commentDic=[[self.contentDic objectForKey:@"comment"] objectAtIndex:indexPath.row];
        CommentCell *cell=(CommentCell*) [tableView dequeueReusableCellWithIdentifier:comment_cell];
        [cell initJsonDic:commentDic];
        return cell;
        
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)dealloc{
    
   ContentViedoCell *videoCell= (ContentViedoCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [videoCell.player stop];
}

#pragma mark - contentTitleDelegate
-(void)upDownBtnPressed:(UIButton *)btn{
    
    if (btn.selected==YES) {
        cellBig=YES;
    }else{
        cellBig=NO;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSArray *reloadIndexPaths = [NSArray arrayWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationFade];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
