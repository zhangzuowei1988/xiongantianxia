//
//  XASpecialTopicViewController.m
//  News
//
//  Created by mac on 2018/5/7.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XASpecialTopicViewController.h"
#import "XANewsTableView.h"

@interface XASpecialTopicViewController ()
{
    UIView *titleView;
}
@property(nonatomic,strong)XANewsTableView *newsView;
@property(nonatomic,assign)BOOL isMore;
@property(nonatomic,strong)NSString *nextPage;
@end

@implementation XASpecialTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitlelabel.text = @"专题";
    [self addTitleView];
    if (CGRectIsNull(self.contentViewFrame)||CGRectEqualToRect(self.contentViewFrame, CGRectZero)) {
        self.newsView=[[XANewsTableView alloc] initWithFrame:CGRectMake(0,titleView.bottom, self.view.frame.size.width, self.view.frame.size.height-titleView.bottom)];
    }else{
        self.newsView=[[XANewsTableView alloc] initWithFrame:self.contentViewFrame];
    }
    [self.view addSubview:self.newsView];
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}
- (void)addTitleView
{
    CGSize labelSize = XA_MULTILINE_TEXTSIZE(_newsModel.title, [UIFont fontWithName:@"PingFangSC-Medium" size:24], CGSizeMake(ScreenWidth-30, 1000), NSLineBreakByCharWrapping);
    
    titleView = [[UIView alloc]initWithFrame:CGRectMake(0, self.originY, ScreenWidth, labelSize.height+30)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, ScreenWidth-30, labelSize.height)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:24];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _newsModel.title;
    [titleView addSubview:titleLabel];

    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(15, titleView.height-1, ScreenWidth-30, 1)];
    bottomLine.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [titleView addSubview:bottomLine];
}
#pragma mark - loadingView
-(void)setLoadingView
{
    if (!self.loadingView) {
        self.loadingView=[[JHUD alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        self.loadingView.messageLabel.text=LOADING_TITLE;
    }
}

#pragma mark - 开始加载
-(void)startLoad{
    
}
#pragma mark - 刷新
-(void)refresh{
    
    if (self.errorView!=nil) {
        [self.errorView setHidden:YES];
    }
    __weak __typeof(self)weakSelf = self;
    [[NewsNetWork shareInstance]getMainListWithLink:self.newsModel.jsonLink WithComplete:^(id result) {
        [self.loadingView hide];
        [weakSelf resetNewsModelWithDict:result];
    } withErrorBlock:^(NSError *error) {
        [weakSelf setErrorViewWithCode:error.code];
        [weakSelf.loadingView hide];
    }];
}
- (void)resetNewsModelWithDict:(NSDictionary *)result
{
    NSArray *carouselArray = result[@"carousel"];
    if (carouselArray.count>0) {//轮播图
        NSArray *carounseModelArr = [XANewsModel mj_objectArrayWithKeyValuesArray:carouselArray];
        self.newsView.cycleModelDataArray = carounseModelArr;
    }
    //新闻列表页的cell有4种，左图右文、上图下文、三图、无图。每隔四个cell放一个上图下文的，如果第五个cell是三图的就跳过，如果是左图右文的就改成上图下文的
    NSArray *newsArray = result[@"articalList"];
    NSArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
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
    NSArray *newsModelArr =[XANewsModel mj_objectArrayWithKeyValuesArray:newsArray];
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
-(void)loadMore
{
    if (self.isMore) {
        __weak __typeof(self)weakSelf = self;
        NSString *url = [NSString stringWithFormat:@"%@%@",self.columItem.columnLink,self.nextPage];
        [[NewsNetWork shareInstance] getMainListWithLink:url WithComplete:^(id result) {
            [self.loadingView hide];
            [weakSelf resetMoreNewsModelWithDict:result];
        } withErrorBlock:^(NSError *error) {
            [weakSelf setErrorViewWithCode:error.code];
            [weakSelf.loadingView hide];
        }];
    } else {
        //如果数据小于10 不显示加载完毕
        if (self.newsView.newsModelDataArray.count<10 ) {
            [self.newsView reloaData];
        } else {
        [self.newsView resetRefreshFooterViewWithMore:NO];
        }
    }
}


@end
