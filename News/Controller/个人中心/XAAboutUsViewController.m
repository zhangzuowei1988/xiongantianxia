//
//  XAAboutUsViewController.m
//  News
//
//  Created by mac on 2018/5/11.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XAAboutUsViewController.h"
@interface XAAboutUsViewController ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *versionLab;
@property (nonatomic,strong)UILabel *contentLab;
@property (nonatomic,strong)UILabel *tipsLab;

@end

@implementation XAAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    [self refresh];
}

#pragma mark - loadingView
-(void)setLoadingView
{
    if (!self.loadingView) {
        self.loadingView=[[JHUD alloc] initWithFrame:CGRectMake(0, self.originY, self.view.frame.size.width, self.view.frame.size.height-self.originY)];
        self.loadingView.messageLabel.text=LOADING_TITLE;
    }
}

/**
 从新加载
 */
-(void)reLoadRequest
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
    [[NewsNetWork shareInstance] getMainListWithLink:aboutUsUrl WithComplete:^(id result) {
        [self.loadingView hide];
        NSDictionary *dict = result[@"data"];
        if(dict){
        self.navBarTitlelabel.text = checkNull(dict[@"title"]);
        NSString *url = checkNull(dict[@"logoFile"]);
        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:icon]];
        NSString *content =[NSString stringWithFormat:@"      %@",checkNull(dict[@"content"])];
            [self setLabelText:content];
        }
        
    } withErrorBlock:^(NSError *error) {
        [weakSelf setErrorViewWithCode:error.code];
        [weakSelf.loadingView hide];
    }];
}

- (void)createUI{
    
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.versionLab];
    [self.view addSubview:self.contentLab];
    _contentLab.frame = CGRectMake(15, _versionLab.bottom+50, ScreenWidth-30, _contentLab.height);
    [self.view addSubview:self.tipsLab];
}

/**
 加载图片

 @return 图片
 */
- (UIImageView *)iconImageView{
    
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-70)/2,self.originY+ 40, 70, 70)];
        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
        [_iconImageView setImage:[UIImage imageNamed:icon]];
        [self.view addSubview:_iconImageView];
    }
    return _iconImageView;
}

/**
 版本label

 */
- (UILabel *)versionLab{
    
    if(!_versionLab){
        
        _versionLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _iconImageView.bottom+5, ScreenWidth, 20)];
        _versionLab.textAlignment = NSTextAlignmentCenter;
        _versionLab.text = [NSString stringWithFormat:@"版本:V%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    }
    
    return _versionLab;
}

/**
 内容介绍

 */
- (UILabel *)contentLab{
    if(!_contentLab){
        _contentLab = [[UILabel alloc]init];
        _contentLab.backgroundColor = [UIColor clearColor];
        _contentLab.textColor = UIColorFromRGB(0x4c4c4c);
        _contentLab.font = [UIFont systemFontOfSize:14.0];
        _contentLab.numberOfLines = 0;
        _contentLab.lineBreakMode = NSLineBreakByCharWrapping;
    }
    
    return _contentLab;
}

/**
 根据字符串的长度设置label的高度

 @param str 要显示的内容
 */
- (void)setLabelText:(NSString*)str
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8.0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    _contentLab.attributedText = attributedString;
   // CGSize labelSize = XA_MULTILINE_TEXTSIZE(str, _contentLab.font, CGSizeMake(ScreenWidth-30, 10000),NSLineBreakByCharWrapping);
//CGSize labelSize = [attributedString boundingRectWithSize:CGSizeMake(ScreenWidth-30, 10000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
   CGSize labelSize = [str boundingRectWithSize:CGSizeMake(ScreenWidth-30, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:_contentLab.font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    _contentLab.height = labelSize.height+16;
}

/**
 底部label

 */
- (UILabel *)tipsLab{
    
    if(!_tipsLab){
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"雄安新区党工委、雄安新区管委会 主办\n人民日报媒体技术股份有限公司 承办"];

        _tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.height-60-70, ScreenWidth, 60)];
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        _tipsLab.numberOfLines = 3;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:6.0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
        _tipsLab.attributedText = attributedString;
        _tipsLab.textColor = UIColorFromRGB(0x4c4c4c);
//        _tipsLab.text = @"雄安新区党工委、雄安新区管委会 主办\n雄安媒体中心 承办\n人民日报媒体技术股份有限公司 技术支持";
        _tipsLab.font = [UIFont systemFontOfSize:12.0];
        _tipsLab.textAlignment = NSTextAlignmentCenter;

    }
    
    return _tipsLab;
}
@end
