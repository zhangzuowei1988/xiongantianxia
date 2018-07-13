//
//  SBView.h
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/10.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SBCommonHeader.h"
#import "SBControlView.h"
#import "SBPauseOrPlayView.h"
//填充模式枚举值
typedef NS_ENUM(NSInteger,SBLayerVideoGravity){
    SBLayerVideoGravityResizeAspect,
    SBLayerVideoGravityResizeAspectFill,
    SBLayerVideoGravityResize,
};
//播放状态枚举值
typedef NS_ENUM(NSInteger,SBPlayerStatus){
    SBPlayerStatusFailed,
    SBPlayerStatusReadyToPlay,
    SBPlayerStatusUnknown,
    SBPlayerStatusBuffering,
    SBPlayerStatusPlaying,
    SBPlayerStatusStopped,
};

@protocol SBPlayerDelegate

-(void)videoPlay;
-(void)videoPause;
-(void)videoStop;
@end

@interface SBPlayer : UIView<SBControlViewDelegate,SBPauseOrPlayViewDelegate,UIGestureRecognizerDelegate>{
    id playbackTimerObserver;
}
@property(nonatomic,weak)id<SBPlayerDelegate>delegate;

@property (nonatomic,strong) AVPlayer *player;

@property (nonatomic,strong) AVPlayerItem *item;
//总时长
@property (nonatomic,assign) CMTime totalTime;
//当前时间
@property (nonatomic,assign) CMTime currentTime;
//资产AVURLAsset
@property (nonatomic,strong) AVURLAsset *anAsset;
//播放器Playback Rate
@property (nonatomic,assign) CGFloat rate;
//播放状态
@property (nonatomic,assign,readonly) SBPlayerStatus status;
//videoGravity设置屏幕填充模式，（只写）
@property (nonatomic,assign) SBLayerVideoGravity mode;
//是否正在播放
@property (nonatomic,assign,readonly) BOOL isPlaying;
//是否全屏
@property (nonatomic,assign,readonly) BOOL isFullScreen;
//设置标题
@property (nonatomic,copy) NSString *title;
//添加标题
@property (nonatomic,strong) UILabel *titleLabel;
//设置thumbImageUrl
@property(nonatomic,strong)NSString *thumbImageStr;

//底部控制视图
@property (nonatomic,strong) SBControlView *controlView;

//暂停和播放视图
@property (nonatomic,strong) SBPauseOrPlayView *pauseOrPlayView;

//当前播放url
@property (nonatomic,strong) NSURL *url;

//与url初始化
-(instancetype)initWithUrl:(NSURL *)url;

//将播放url放入资产中初始化播放器
-(void)assetWithURL:(NSURL *)url;


//公用同一个资产请使用此方法初始化
-(instancetype)initWithAsset:(AVURLAsset *)asset;

-(void)setupPlayerWithAsset;

//播放
-(void)play;
//暂停
-(void)pause;
//停止 //移除当前视频播放下一个，调用Stop方法
-(void)stop;

@end
