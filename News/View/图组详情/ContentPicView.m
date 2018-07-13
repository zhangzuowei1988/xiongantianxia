//
//  ContentPicView.m
//  News
//
//  Created by pdmi on 2017/5/27.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "ContentPicView.h"
#import "ContentPicCell.h"
#import "XAPicListModel.h"
#import "PDMIJSON.h"
static NSString *contentPicCell=@"ContentPicCell";

@interface ContentPicView()<UIGestureRecognizerDelegate>{
    NSDictionary *contentPicDic;
}

@end;
@implementation ContentPicView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.picCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        self.picCollectionView.delegate=self;
        self.picCollectionView.dataSource=self;
        self.picCollectionView.pagingEnabled=YES;
        
        [self.picCollectionView registerClass:[ContentPicCell class] forCellWithReuseIdentifier:contentPicCell];
        [self addSubview:self.picCollectionView];
    }
    return self;
}
-(void)setPicModelArrays:(NSArray *)picModelArrays
{
    _picModelArrays  = picModelArrays;
    [self.picCollectionView reloadData];
}

#pragma mark  - collectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _picModelArrays.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XAPicListModel *imageModel=[_picModelArrays objectAtIndex:indexPath.section];
    ContentPicCell *cell = (ContentPicCell *)[collectionView dequeueReusableCellWithReuseIdentifier:contentPicCell forIndexPath:indexPath];
    cell.currentPic = [NSString stringWithFormat:@"%ld/%ld",(indexPath.section+1),_picModelArrays.count];
    cell.picListModel = imageModel;
    return cell;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width=self.frame.size.width;
    
    return CGSizeMake(width, self.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* result = [super hitTest:point withEvent:event];
    
    return result;
    
    
}

@end
