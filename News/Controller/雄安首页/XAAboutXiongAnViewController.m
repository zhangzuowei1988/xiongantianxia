//
//  XAAboutXiongAnViewController.m
//  News
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAAboutXiongAnViewController.h"
#import "XAAboutHeadView.h"
#import "XANewsTableView.h"

@interface XAAboutXiongAnViewController ()
@property(nonatomic,strong)XANewsTableView *newsView;
@property(nonatomic,strong)XAAboutHeadView *headView;
@property(nonatomic,assign)BOOL isMore;
@property(nonatomic,strong)NSString *nextPage;

@end

@implementation XAAboutXiongAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    if (CGRectIsNull(self.contentViewFrame)||CGRectEqualToRect(self.contentViewFrame, CGRectZero)) {
        self.newsView=[[XANewsTableView alloc] initWithFrame:CGRectMake(0,self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY-self.tabHeight)];
    }else{
        self.newsView=[[XANewsTableView alloc] initWithFrame:self.contentViewFrame];
    }
    self.newsView.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.newsView];
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}

/**
 tableHeadView

 */
-(XAAboutHeadView *)headView
{
    if (_headView==nil) {
        _headView = [[XAAboutHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 136+ScreenWidth*197/375)];
    }
    return _headView;
}
#pragma mark - loadingView
-(void)setLoadingView
{
    if (!self.loadingView) {
        self.loadingView=[[JHUD alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        self.loadingView.messageLabel.text=LOADING_TITLE;
    }
}
#pragma mark - 从新加载
-(void)reLoadRequest{
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}
#pragma mark - 刷新
-(void)refresh{
    
    if (self.errorView!=nil) {
        [self.errorView setHidden:YES];
    }
    __weak __typeof(self)weakSelf = self;
    [[NewsNetWork shareInstance]getMainListWithLink:self.columItem.columnLink WithComplete:^(id result) {
        [self.loadingView hide];
        [weakSelf resetNewsModelWithDict:result];
    } withErrorBlock:^(NSError *error) {
        if (self.newsView.newsModelDataArray.count==0) {
            [weakSelf setErrorViewWithCode:error.code];
        }
        [weakSelf.loadingView hide];
        [self.newsView reloaData];
    }];
}

/**
 处理下载数据
 */
- (void)resetNewsModelWithDict:(NSDictionary *)result
{
    NSString *topImageUrl = result[@"topImg"];
    NSDictionary *subsection = result[@"subsection"];
    self.isMore =[result[@"isMore"] boolValue];
    self.nextPage = result[@"nextPage"];

    self.headView.introduceUrl = subsection[@"introduce"];
    self.headView.organsUrl = subsection[@"organs"];
    self.headView.leaderUrl = subsection[@"leader"];

    self.headView.topImageUrl = topImageUrl;
    NSArray *carouselArray = result[@"carousel"];
    if (carouselArray.count>0) {//轮播图
        NSArray *carounseModelArr = [XANewsModel mj_objectArrayWithKeyValuesArray:carouselArray];
        self.newsView.cycleModelDataArray = carounseModelArr;
    }
    
    NSArray *newsArray = result[@"list"];
    NSMutableArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
    NSArray *advertArray = result[@"advert"];
    NSArray *advertModelArray = [XANewsModel mj_objectArrayWithKeyValuesArray:advertArray];
    for (XANewsModel *advertModel in advertModelArray) {
        if(advertModel.title){
            if (advertModel.numbersIndex<newsModelArr.count) {
                [newsModelArr insertObject:advertModel atIndex:advertModel.numbersIndex];
            }else {
                [newsModelArr addObject:advertModel];
            }
        }
    }
    //新闻列表页的cell有4种，左图右文、上图下文、三图、无图。每隔四个cell放一个上图下文的，如果第五个cell是三图的就跳过，如果是左图右文的就改成上图下文的
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [newsModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XANewsModel *newsModel = obj;
            if (idx>0&&idx%4==0) {
                if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
                    newsModel.newsCellPicType=NewsCellPicTypeTop;
                }
            }
            if (newsModel.contentType==NewsTypeTopic) {
                newsModel.newsCellPicType=NewsCellPicTypeTop;
            }
            [newsModel caculateFrame];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsView.newsModelDataArray =newsModelArr;
            [self.newsView reloaData];
        });
    });
}
//加载更多
-(void)loadMore
{
    if (self.isMore) {
        __weak __typeof(self)weakSelf = self;
        NSString *url = [NSString stringWithFormat:@"%@%@",self.columItem.columnLink,self.nextPage];
        [[NewsNetWork shareInstance] getMainListWithLink:url WithComplete:^(id result) {
            [self.loadingView hide];
            [weakSelf resetMoreNewsModelWithDict:result];
        } withErrorBlock:^(NSError *error) {
//            [weakSelf setErrorViewWithCode:error.code];
            [weakSelf.loadingView hide];
            [self.newsView reloaData];

        }];
    } else {
        [self.newsView resetRefreshFooterViewWithMore:NO];
    }
}
- (void)resetMoreNewsModelWithDict:(NSDictionary *)result
{
    self.isMore =[result[@"isMore"] boolValue];
    self.nextPage = result[@"nextPage"];
    NSArray *carouselArray = result[@"carousel"];
    if (carouselArray.count>0) {//轮播图
        NSArray *carounseModelArr = [XANewsModel mj_objectArrayWithKeyValuesArray:carouselArray];
        self.newsView.cycleModelDataArray = carounseModelArr;
    }
    
    NSArray *newsArray = result[@"list"];
    NSMutableArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
    NSArray *advertArray = result[@"advert"];
    NSArray *advertModelArray = [XANewsModel mj_objectArrayWithKeyValuesArray:advertArray];
    for (XANewsModel *advertModel in advertModelArray) {
        if(advertModel.title){
            if (advertModel.numbersIndex<newsModelArr.count) {
                [newsModelArr insertObject:advertModel atIndex:advertModel.numbersIndex];
            }else {
                [newsModelArr addObject:advertModel];
            }
        }
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *totalArray = [[NSMutableArray alloc]initWithArray:self.newsView.newsModelDataArray];
        [totalArray addObjectsFromArray:newsModelArr];
        //新闻列表页的cell有4种，左图右文、上图下文、三图、无图。每隔四个cell放一个上图下文的，如果第五个cell是三图的就跳过，如果是左图右文的就改成上图下文的
        [totalArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XANewsModel *newsModel = obj;
            if (idx>0&&idx%4==0) {
                if (newsModel.newsCellPicType==NewsCellPicTypeLeft) {
                    newsModel.newsCellPicType=NewsCellPicTypeTop;
                }
            }
            if (newsModel.contentType==NewsTypeTopic) {
                newsModel.newsCellPicType=NewsCellPicTypeTop;
            }
            [newsModel caculateFrame];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsView.newsModelDataArray =totalArray;
            [self.newsView reloaData];
        });
    });
}

//-(void)refresh{
//    
//    if (self.errorView!=nil) {
//        [self.errorView setHidden:YES];
//    }
//    __weak __typeof(self)weakSelf = self;
//    
//    [[NewsNetWork shareInstance]getMainListWithLink:self.columItem.columnLink WithComplete:^(id result) {
//        [self.loadingView hide];
//        //        if ([@"热点" isEqualToString:self.navigationController.title]) {
//        
//        [weakSelf resetHotModelWithDic:[result objectForKey:@"data"]];
//        //        }else{
//        //        [weakSelf resetModelWithDic:[result objectForKey:@"data"]];
//        //        }
//        
//        
//    } withErrorBlock:^(NSError *error) {
//        [weakSelf setErrorView];
//        
//        [weakSelf.loadingView hide];
//    }];
//    
//    
//}
//-(void)resetHotModelWithDic:(NSDictionary *)modelDic
//{
//    self.dataModel=[self getNewsModelWithDic:modelDic];
//    NSMutableArray *modelArr = [NSMutableArray array];
//    if  (self.dataModel.columnType.intValue == 1){
//        
//        
//        modelArr=[self getNewsListModelWithDic:modelDic[@"newsList"][@"listTab"]];
//        
//        NSMutableArray *listmodelArr=[self getNewsListModelWithDic:modelDic[@"newsList"][@"indexTab"]];
//        
//        [self resetModelWithArr:modelArr];
//        
//        if (listmodelArr.count > 0) {
//            
//            
//            NewsListModel *bunnerModel =[listmodelArr objectAtIndex:0];
//            //         NewsListModel *bunnerModel =[[ NewsListModel alloc]init];
//            
//            bunnerModel.displayType = 5;
//            bunnerModel.listmodelArr =  listmodelArr;
//            [modelArr insertObject:bunnerModel atIndex:0];
//            
//            
//        }
//        
//        
//        
//    }else {
//        modelArr=[self getNewsListModelWithDic:[modelDic objectForKey:@"newsList"]];
//        
//    }
//    //    [self resetModelWithArr:modelArr];
//    
//    
//    self.newsView.listArr = modelArr;
//    self.dataModel.listModelArr=self.newsView.listArr;
//    [self.newsView reloaData];
//}
//
//-(void)resetModelWithArr:(NSMutableArray *)modelArr{
//    
//    [modelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        NewsListModel *model=obj;
//        if (idx%10==3) {
//            model.displayType=3;
//        }else if (idx%10==8){
//            model.displayType=4;
//        }
//        if(model.imageUrls.count>0){
//            
//            NSString *imageStr=[model.imageUrls objectAtIndex:0];
//            if (imageStr.length == 0 ) {
//                model.displayType=0;
//                
//            }
//        }else{
//            
//            model.displayType=0;
//            
//        }
//        
//        
//        
//    }];
//    
//}
//
//-(void)resetModelWithDic:(NSDictionary *)modelDic
//{
//    self.dataModel=[self getNewsModelWithDic:modelDic];
//    
//    NSMutableArray *modelArr=[self getNewsListModelWithDic:[modelDic objectForKey:@"newsList"]];
//    
//    if ([modelArr count]>3) {
//        
//        int num=0;
//        for (int i=0; i<3; i++) {
//            NewsListModel *model=[modelArr objectAtIndex:i];
//            if (model.displayType!=0) {
//                num++;
//            }
//        }
//        if (num==3) {
//            NewsListModel *model=[modelArr objectAtIndex:0];
//            model.displayType=5;
//            model.listmodelArr=[modelArr subarrayWithRange:NSMakeRange(0, 3)];
//            
//            [modelArr removeObjectsInRange:NSMakeRange(0, 3)];
//            [modelArr insertObject:model atIndex:0];
//        }
//    }
//    
//    [self resetModelWithArr:modelArr];
//    
//    self.newsView.listArr=modelArr;
//    self.dataModel.listModelArr=self.newsView.listArr;
//    [self.newsView reloaData];
//    
//}
//-(int)getRandomNumber:(int)from to:(int)to
//{
//    return (int)(from + (arc4random() % (to -from + 1)));
//}
//#pragma mark - 加载更多
//-(void)loadMore{
//    
//    if (self.dataModel.isMore==true) {
//        __weak __typeof(self)weakSelf = self;
//        
//        [[NewsNetWork shareInstance]getMainListWithLink:[NSString stringWithFormat:@"%@%@",self.columItem.columnLink,self.dataModel.nextPage ] WithComplete:^(id result) {
//            
//            if ([@"热点" isEqualToString:self.navigationController.title]) {
//                
//                weakSelf.dataModel=[weakSelf getNewsModelWithDic:[result objectForKey:@"data"]];
//                
//                NSMutableArray *modelArr=[[NSMutableArray alloc] initWithArray:weakSelf.newsView.listArr];
//                [modelArr addObjectsFromArray:[weakSelf getNewsListModelWithDic:result[@"data"][@"newsList"][@"listTab"]]];
//                //                [weakSelf resetModelWithArr:modelArr];
//                weakSelf.newsView.listArr=modelArr;
//                weakSelf.dataModel.listModelArr=modelArr;
//                [weakSelf.newsView reloaData];
//                
//            }else{
//                weakSelf.dataModel=[weakSelf getNewsModelWithDic:[result objectForKey:@"data"]];
//                
//                NSMutableArray *modelArr=[[NSMutableArray alloc] initWithArray:weakSelf.newsView.listArr];
//                [modelArr addObjectsFromArray:[weakSelf getNewsListModelWithDic:[[result objectForKey:@"data"] objectForKey:@"newsList"]]];
//                [weakSelf resetModelWithArr:modelArr];
//                weakSelf.newsView.listArr=modelArr;
//                weakSelf.dataModel.listModelArr=modelArr;
//                [weakSelf.newsView reloaData];
//            }
//            
//            
//        } withErrorBlock:^(NSError *error) {
//            
//            [weakSelf.newsView loadError];
//        }];
//        
//    }else{
//        [self.newsView resetRefreshFooterViewWithMore:NO];
//    }
//    
//    
//    
//    
//    
//    //    NSString *jsonStr=[[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newsListJson" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
//    //    [self.newsView.listArr addObjectsFromArray:[self getNewsListModelWithDic:[jsonStr JSONObject]]];
//    //    [self.newsView reloaData];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
