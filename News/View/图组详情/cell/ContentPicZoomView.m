//
//  ContentPicZoomView.m
//  News
//
//  Created by pdmi on 2017/5/31.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "ContentPicZoomView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCache.h"
#define HandDoubleTap 2
#define HandOneTap 1
#define MaxZoomScaleNum 1.5
#define MinZoomScaleNum 1.0
@implementation ContentPicZoomView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
         [self initView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
   
}
- (void)initView {
    
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //_scrollView=[UIScrollView new];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    [_scrollView addSubview:_containerView];
    
    [self addSubview:_scrollView];
    

    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
   
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setClipsToBounds:YES];
    [_containerView addSubview:_imageView];
    //双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(TapsAction:)];
    [doubleTapGesture setNumberOfTapsRequired:HandDoubleTap];
    [_containerView addGestureRecognizer:doubleTapGesture];
    
    //单击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(TapsAction:)];
    [tapGesture setNumberOfTapsRequired:HandOneTap];
    [_containerView addGestureRecognizer:tapGesture];
    
    //双击失败之后执行单击
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    
    
    
    //    CGSize showSize = [self newSizeByoriginalSize:self.image.size maxSize:self.bounds.size];
    //
    //    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, showSize.width, showSize.height)];
    //    imgview.image = self.image;
    //     self.imageView = imgview;
    //    [imgview release];
    
    self.scrollView.maximumZoomScale = MaxZoomScaleNum;
    self.scrollView.minimumZoomScale = MinZoomScaleNum;
    self.scrollView.zoomScale = MinZoomScaleNum;
    
}
- (void)resetViewFrame:(CGRect)newFrame
{
    self.frame = newFrame;
    _scrollView.frame = self.bounds;
    _containerView.frame = self.bounds;
    
   
   
}
- (void)uddateImageWithUrl:(NSString *)imgUrl
{
    
    _imageView.frame=CGRectMake(0, 0, self.frame.size.width, 290*[CommData shareInstance].scale);
    _scrollView.zoomScale = 1;
    _scrollView.contentOffset = CGPointZero;
    _containerView.bounds = _imageView.bounds;
  
    _scrollView.zoomScale  = _scrollView.minimumZoomScale;
    [self scrollViewDidZoom:_scrollView];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[CommData shareInstance].placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
}

- (BOOL)isViewing {
    return (_scrollView.zoomScale != _scrollView.minimumZoomScale);
}
#pragma mark- 手势事件
//单击 / 双击 手势
- (void)TapsAction:(UITapGestureRecognizer *)tap
{
    NSInteger tapCount = tap.numberOfTapsRequired;
    if (HandDoubleTap == tapCount) {
        //双击
        NSLog(@"双击");
        if (self.scrollView.minimumZoomScale <= self.scrollView.zoomScale && self.scrollView.maximumZoomScale > self.scrollView.zoomScale) {
            [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
        }else {
            [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
        }
        
    }else if (HandOneTap == tapCount) {
        //单击
        NSLog(@"单击");
        //        NSLog(@"imgUrl: %@, imgSize:(%f, %f) zoomScale:%f",downImgUrl,self.imageView.frame.size.width,self.imageView.frame.size.height,self.scrollView.zoomScale);
        
    }
}
#pragma mark- Scrollview delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _containerView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _containerView.frame.size.width;
    CGFloat H = _containerView.frame.size.height;
    
    CGRect rct = _containerView.frame;
    rct.origin.x = MAX((Ws-W)*0.5, 0);
    rct.origin.y = MAX((Hs-H)*0.4, 0);
    _containerView.frame = rct;
    
//    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.left.equalTo(_scrollView).with.offset( rct.origin.x);
//         make.top.equalTo(_scrollView).with.offset(rct.origin.y);
//    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
