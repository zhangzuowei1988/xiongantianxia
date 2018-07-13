//
//  XAServiceViewController.m
//  News
//
//  Created by mac on 2018/4/28.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAServiceViewController.h"
#import "XAAffairsCollectionCell.h"
#import "XAAffairsHeadView.h"
#import "XAAffairsModel.h"
#import "H5NewsDetailController.h"
#import "MJRefresh.h"

#import "XAServiceListViewController.h"
static NSString *cellID = @"cellId";
static NSString *viewID = @"viewId";

@interface XAServiceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *_dataArray;
}
@end

@implementation XAServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarTitlelabel.text = @"雄安 • 办事";
    [self addCollectionView];
    //loading框
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];

    [self refresh];
}

- (void)addCollectionView
{
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.originY, ScreenWidth, self.view.height-self.originY-self.tabHeight) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[XAAffairsCollectionCell class] forCellWithReuseIdentifier:cellID];
    [_collectionView registerClass:[XAAffairsHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:viewID];
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }] ;
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray[section] count]-1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XAAffairsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.affairsModel = _dataArray[indexPath.section][indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    XAAffairsHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:viewID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        view.titleLabel.text = @"企业办事";
    }else {
        view.titleLabel.text = @"个人办事";
    }
    return view;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(48, 75);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth, 32);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(18, 40, 38, 40);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 34;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XAAffairsModel *affairsModel = _dataArray[indexPath.section][indexPath.row];
    XAServiceListViewController *detailController = [[XAServiceListViewController alloc]init];
    detailController.urlStr = affairsModel.link;
    detailController.titleName = affairsModel.name;
    [self.navigationController pushViewController:detailController animated:YES];
}
#pragma mark - 重新加载
- (void)reLoadRequest
{
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    
    [self refresh];
}
#pragma mark - 刷新
-(void)refresh{
    if (self.errorView!=nil) {
        [self.errorView setHidden:YES];
    }
    __weak __typeof(self)weakSelf = self;
    [[NewsNetWork shareInstance] getMainListWithLink:xionganAffairsUrl WithComplete:^(id result) {
        [self.loadingView hide];
        [weakSelf resetNewsModelWithDict:result];
    } withErrorBlock:^(NSError *error) {
        if (_dataArray.count==0) {
            [weakSelf setErrorViewWithCode:error.code];
        }
        [weakSelf.loadingView hide];
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
    }];
}

/**
 绑定数据

 */
- (void)resetNewsModelWithDict:(NSDictionary *)result
{
    NSArray *businessArr = [XAAffairsModel mj_objectArrayWithKeyValuesArray:result[@"business"]];
    NSArray *personalArr = [XAAffairsModel mj_objectArrayWithKeyValuesArray:result[@"personal"]];
    _dataArray = @[businessArr,personalArr];
    [_collectionView reloadData];
    [_collectionView.mj_header endRefreshing];

//    self.isMore =[result[@"isMore"] boolValue];
//    self.nextPage = result[@"nextPage"];
//    NSArray *carouselArray = result[@"carousel"];
//    if (carouselArray.count>0) {//轮播图
//        NSArray *carounseModelArr = [XANewsModel mj_objectArrayWithKeyValuesArray:carouselArray];
//        self.newsView.cycleModelDataArray = carounseModelArr;
//    }
//
//    NSArray *newsArray = result[@"list"];
//    NSArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [newsModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            XANewsModel *newsModel = obj;
//            if (idx>0&&idx%5==0) {
//                if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
//                    newsModel.newsCellPicType=NewsCellPicTypeTop;
//                }
//            }
//            if (newsModel.contentType==3) {
//                newsModel.newsCellPicType=NewsCellPicTypeTop;
//            }
//            [newsModel caculateFrame];
//        }];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.newsView.newsModelDataArray =newsModelArr;
//            [self.newsView reloaData];
//        });
//    });
}

@end
