//
//  PDMITabBarController.m
//  News
//
//  Created by pdmi on 2017/4/27.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "PDMITabBarController.h"
#import "NewsViewController.h"
#import "PDMINavigationController.h"

#import "SDWebImageManager.h"
#import "VersionModel.h"
#import "PDMISandboxFile.h"
@interface PDMITabBarController ()

@property(nonatomic,strong)NSDictionary *versionDic;
@property(nonatomic,strong)NSMutableArray *rItemmodelArr;
@property(nonatomic,strong)NewsViewController *Rvc;
@end

@implementation PDMITabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //读取配置文件
    NSString *configFilePath=[[NSBundle mainBundle] pathForResource:@"configure/config-version" ofType:@"json"];
    [self initConfigureDataWithPath:configFilePath];
    self.selectedIndex = 1;
}

/**读取配置信息

 @param filePath 配置信息沙盒路径
 */
-(void)initConfigureDataWithPath:(NSString *)filePath
{
     NSString *jsonStr=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    VersionModel *versionMode=[[VersionModel alloc] initWithDictionary:[[jsonStr JSONObject] objectForKey:@"data"]];
    CommData.shareInstance.configModel=versionMode.configModel;
    for (int i=0; i<versionMode.pages.count; i++) {
        PageModel *model=[versionMode.pages objectAtIndex:i];
        NewsViewController *vc1 = [[NewsViewController alloc] init];
        if ([model.tabTitle isEqualToString:@"新闻"]) {
//            if (model.columnList.count ==0) {
//                model.columnList = [CommData shareInstance].getHotspotData;
//            }
            self.Rvc = vc1;
        }
        vc1.pageModel=model;
        [self addChildViewController:vc1 withImage:model.tabImage selectedImage:model.selectImage withTittle:model.tabTitle];
        if (i==4) {//最多显示5个
            break;
        }
    }
    [[UITabBar appearance] setBarTintColor:CommData.shareInstance.configModel.tabBackgroundColor];
    [UITabBar appearance].translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 处理图片 根据reSize的大小放大或缩小图片

 @param image 要处理的图片
 @param reSize 处理后图片的大小
 @return 处理后的图片
 */
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*0.9, image.size.height*0.9));
    [image drawInRect:CGRectMake(0, 0, image.size.width*0.9, image.size.width*0.9)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

/**
 添加tabbar的子controller

 @param controller 控制器
 @param imageUrl 底部图标
 @param selectImageUrl 底部选中图片
 @param tittle 底部标题
 */
- (void)addChildViewController:(UIViewController *)controller withImage:(NSString *)imageUrl selectedImage:(NSString *)selectImageUrl withTittle:(NSString *)tittle{
    ConfigModel *configModel=CommData.shareInstance.configModel;
    PDMINavigationController *nav = [[PDMINavigationController alloc] initWithRootViewController:controller];
    
//    [nav.tabBarItem setImage:[[UIImage imageNamed:imageUrl] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImageUrl] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image=[weakSelf downLoadImageWithUrl:imageUrl];
        // 耗时的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [nav.tabBarItem setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            });
     });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image=[weakSelf downLoadImageWithUrl:selectImageUrl];
        // 耗时的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
             [nav.tabBarItem setSelectedImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        });
    });
    //    nav.tabBarItem.title = tittle;
    //    controller.navigationItem.title = tittle;
    controller.title = tittle;//这句代码相当于上面两句代码
    
//    NSMutableDictionary *attrnor = [NSMutableDictionary dictionary];
//
//    // 设置字体
//    attrnor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//
//    [nav.tabBarItem setTitleTextAttributes:attrnor forState:UIControlStateNormal];
//    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
//    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:13]} forState:UIControlStateSelected];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: configModel.tabTitleSelectColor,NSFontAttributeName: [UIFont boldSystemFontOfSize:13]} forState:UIControlStateSelected];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: configModel.tabTitleColor,NSFontAttributeName: [UIFont boldSystemFontOfSize:13]} forState:UIControlStateNormal];

//    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [self addChildViewController:nav];
    
}
- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

/**
 下载底部图标

 @param imageUrl 图标地址 如果是URL就从服务器获取，否则就加载本地的
 @return 
 */
-(UIImage *)downLoadImageWithUrl:(NSString *)imageUrl
{
    if ([imageUrl rangeOfString:@"http"].location!=NSNotFound) {
        NSString *imageName=[imageUrl lastPathComponent];
        if ([imageName rangeOfString:@"."].location!=NSNotFound) {
            NSArray *arr=[imageName componentsSeparatedByString:@"."];
            imageName=[NSString stringWithFormat:@"%@@2x.%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
        }
        NSString *filePath=[[[CommData shareInstance] getConfigureImagePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",imageName]];
        if ([PDMISandboxFile isFileExists:filePath]) {
            UIImage *image=[UIImage imageWithContentsOfFile:filePath];
            
           // return [self reSizeImage:image toSize:CGSizeMake(50, 50)];
            return image;
         
        }else{
            UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
//            NSString *folderPath=[[CommData shareInstance] getConfigureImagePath];
//            if (![PDMISandboxFile isFileExists:folderPath]) {
//                [PDMISandboxFile createFilePath:folderPath error:nil];
//            }
           UIImage *resizeImage=[self reSizeImage:image toSize:CGSizeMake(50, 50)];
           [PDMISandboxFile writeUImage:resizeImage toFilePath:filePath];
            return  [UIImage imageWithContentsOfFile:filePath];
        }
    }else{
        return [UIImage imageNamed:imageUrl];

    }
}

@end
