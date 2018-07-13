//
//  DLScrollTabbarView.m
//  DLSlideViewDemo
//
//  Created by Dongle Su on 15-2-12.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import "DLScrollTabbarView.h"
#import "DLUtility.h"

#define kTrackViewHeight 2
#define kImageSpacingX 3.0f

#define kLabelTagBase 1000
#define kImageTagBase 2000
#define kSelectedImageTagBase 3000
#define kViewTagBase 4000

static CGFloat kAddChannelWidth = 37;
//@implementation DLScrollTabbarItem
//+ (DLScrollTabbarItem *)itemWithTitle:(NSString *)title width:(CGFloat)width columnId:(NSString *)columnId{
//    DLScrollTabbarItem *item = [[DLScrollTabbarItem alloc] init];
//    item.title = title;
//    item.width = width;
//    item.columnId=columnId;
//    return item;
//}
//@end


@implementation DLScrollTabbarView{
    //UIScrollView *scrollView_;
    UIImageView *trackView_;
}
@synthesize   scrollView_;
- (void)commonInit{
    
//    self.tabItemNormalFontSize = [CommData shareInstance].scale*SecondTitleFontSize;
//    self.tabItemSelectedFontSize=[CommData shareInstance].scale*FirstTitleFontSize;
    
    _selectedIndex = -1;
    
    scrollView_ = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView_.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView_];
    
   // trackView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-kTrackViewHeight-1, self.bounds.size.width, kTrackViewHeight)];
    trackView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-kTrackViewHeight-1, 30, kTrackViewHeight)];
    [scrollView_ addSubview:trackView_];
    trackView_.layer.cornerRadius = 1.0f;
    
    self.backgroundColor=[CommData shareInstance].configModel.columnBackgroundColor;
    //self.backgroundColor=[UIColor redColor];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)setBackgroundView:(UIView *)backgroundView{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        [self insertSubview:backgroundView atIndex:0];
        _backgroundView = backgroundView;
    }
}

- (void)setTabItemNormalColor:(UIColor *)tabItemNormalColor{
    _tabItemNormalColor = tabItemNormalColor;
    
    for (int i=0; i<[self tabbarCount]; i++) {
        if (i == self.selectedIndex) {
            continue;
        }
        UILabel *label = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+i];
        label.textColor = tabItemNormalColor;
    }
}

- (void)setTabItemSelectedColor:(UIColor *)tabItemSelectedColor{
    _tabItemSelectedColor = tabItemSelectedColor;
    
    UILabel *label = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+self.selectedIndex];
    label.textColor = tabItemSelectedColor;
}

- (void)setTrackColor:(UIColor *)trackColor{
    _trackColor = trackColor;
    trackView_.backgroundColor = trackColor;
}
-(void)setShowAddBtn:(BOOL )show{
    if (_showAddBtn!=show) {
        _showAddBtn=show;
        if (show==YES) {
            [self addSubview:[self createTheAddButton]];
          //  [self addSubview:[self createEditButton]];
          
        }
    }
    
}
- (void)setTabbarItems:(NSArray *)tabbarItems{
    
    if (_tabbarItems != tabbarItems) {
        
//        if (self.selectedIndex&&self.tabbarItems) {
//            PDMITagItem *selectItem=[self.tabbarItems objectAtIndex:self.selectedIndex ];
//            
//            __block NSInteger index=0;
//            [tabbarItems enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                PDMITagItem *item=obj;
//                if ([item isEqual:selectItem]) {
//                    index=idx;
//                }
//            }];
//            
//                self.selectedIndex=index;
//            
//        }
        
       _tabbarItems = tabbarItems;
       
        
        for(UIView *view in [scrollView_ subviews])
        {
            if (view.tag>=4000) {
                 [view removeFromSuperview];
            }
           
        }

      
        float height = self.bounds.size.height;
        float x = 0.0f;
        NSInteger i=0;
        for (PDMITagItem *item in tabbarItems) {
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, item.width, height)];
            backView.backgroundColor = [UIColor clearColor];
            backView.tag = kViewTagBase + i;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, item.width, height)];
            [label setTextAlignment:NSTextAlignmentCenter];
            label.text = item.columnTitle;
            if (self.selectedIndex==i) {
                label.textColor=self.tabItemSelectedColor;
         
           label.font = [[CommData shareInstance]setLabelFountWithSize:self.tabItemSelectedFontSize];
;
            }else{
              
                label.font = [[CommData shareInstance]setLabelFountWithSize:self.tabItemNormalFontSize];
                label.textColor = self.tabItemNormalColor;
            }
            
            label.backgroundColor = [UIColor clearColor];
            
            [label sizeToFit];
            label.tag = kLabelTagBase+i;
            
//            UILabel *tempLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, item.width, height)];
//            tempLabel.text=item.columnTitle;
//            tempLabel.font=[UIFont systemFontOfSize:self.tabItemSelectedFontSize];
            
            
          
            
            CGSize selectSize=[self caculateLabelHeight:item.columnTitle withFont:[[CommData shareInstance]setLabelFountWithSize:self.tabItemSelectedFontSize]];
           
            label.frame = CGRectMake((item.width-selectSize.width)/2.0f, (height-label.bounds.size.height)/2.0f,selectSize.width, CGRectGetHeight(label.bounds));
            
           // label.frame = CGRectMake((item.width-label.bounds.size.width)/2.0f, (height-label.bounds.size.height)/2.0f, CGRectGetWidth(label.bounds), CGRectGetHeight(label.bounds));
            
            //label.frame = CGRectMake((item.width-(label.bounds.size.width+13))/2.0f, (height-(label.bounds.size.height+7))/2.0f, CGRectGetWidth(label.bounds)+13, CGRectGetHeight(label.bounds)+7);
            
            [backView addSubview:label];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [backView addGestureRecognizer:tap];

            [scrollView_ addSubview:backView];
            x += item.width;
            i++;
        }
        scrollView_.contentSize = CGSizeMake(x, height);

        [self layoutTabbar];
        if (self.showAddBtn) {
            
             scrollView_.contentSize = CGSizeMake(x+kAddChannelWidth, height);
            
        }
    }
    
   
}

#pragma mark 创建右侧的加号Button
- (UIButton *)createTheAddButton {
    
    self.addChannelButton =[UIButton buttonWithType:UIButtonTypeCustom];
    // addChannelButton.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x343434, 0xfafafa);
   // self.addChannelButton.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
    self.addChannelButton.backgroundColor=[CommData shareInstance].configModel.columnBackgroundColor;
    [self.addChannelButton setImage:[UIImage imageNamed:@"home_header_add_slim"] forState:UIControlStateNormal];
    self.addChannelButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - kAddChannelWidth-5, 0, kAddChannelWidth, kAddChannelWidth);
    self.addChannelButton.center=CGPointMake(self.addChannelButton.center.x,  scrollView_.center.y);
    [self.addChannelButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.addChannelButton.layer.shadowOffset =  CGSizeMake(-10,0);
    self.addChannelButton.layer.shadowOpacity = 0.6;
    
//    [self.addChannelButton.layer setShadowPath:[[UIBezierPath
//                                           bezierPathWithRect:CGRectMake(0, 0, -30, self.addChannelButton.frame.size.height)] CGPath]];
    self.addChannelButton.layer.shadowColor =  [CommData shareInstance].configModel.columnBackgroundColor.CGColor;
    
//   CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)setRGBColor(0, 0, 0, 0.5).CGColor, (__bridge id)setRGBColor(0, 0, 0, 0.2).CGColor, (__bridge id)setRGBColor(0, 0, 0,0.0).CGColor];
//    gradientLayer.locations = @[@0.0, @0.4, @0.8];
//    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
//    gradientLayer.endPoint = CGPointMake(0.0, 0.8);
    
    
    return self.addChannelButton;
}
//#pragma mark lineView
//-(UIView *)createLineView{
//    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.addChannelButton), CGRectGetMinY(self.addChannelButton), 2, self.addChannelButton.frame.size.height)];
//    lineView.backgroundColor=[];
//}

-(UIButton *)createEditButton{
    self.editBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-100, 0, 56, 22)];
    self.editBtn.center=CGPointMake(self.editBtn.center.x, self.frame.size.height/2);
    self.editBtn.layer.borderColor=[CommData shareInstance].skinColor.CGColor;
    self.editBtn.layer.borderWidth=1;
    self.editBtn.layer.cornerRadius=11;
    [self.editBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:10]];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:[CommData shareInstance].skinColor forState:UIControlStateNormal];
    
    [self.editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [self.editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.editBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:[CommData shareInstance].scale*FourthTitleFontSize]];
    
   // [self.editBtn setTitleColor:[CommData shareInstance].skinColor forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn.hidden=YES;
    self.editBtn.backgroundColor=[UIColor clearColor];
    return self.editBtn;
}


#pragma mark 点击addButton,展示或隐藏添加channel的View
- (void)clickAddButton:(UIButton *)button{
    
    
    if (button.selected==NO) {
//        self.addChannelButton.layer.shadowOpacity = 0.0;
//        button.backgroundColor=[UIColor clearColor];
//        button.selected=YES;
//        scrollView_.hidden=YES;
//        self.editBtn.hidden=NO;
//        [UIView animateWithDuration:0.1 animations:^{
//            button.transform = CGAffineTransformRotate(button.transform, M_PI_4);
//
//        } completion:^(BOOL finished) {
//            [button setImage:[UIImage imageNamed:@"close_black_img"] forState:UIControlStateNormal];
   //     }];
        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.1];
//
//        button.transform = CGAffineTransformRotate(button.transform, M_PI_4);
//        [UIView commitAnimations];
        
    }else{
        
//        button.selected=NO;
//        scrollView_.hidden=NO;
//        self.editBtn.hidden=YES;
//        [UIView animateWithDuration:0.1 animations:^{
//
//            button.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            self.addChannelButton.layer.shadowOpacity = 0.6;
//             button.backgroundColor=[CommData shareInstance].configModel.columnBackgroundColor;
//            [button setImage:[UIImage imageNamed:@"home_header_add_slim"] forState:UIControlStateNormal];

//        }];
        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.1];
//        button.backgroundColor=[CommData shareInstance].configModel.columnBackgroundColor;
//        button.transform = CGAffineTransformIdentity;
//        [UIView commitAnimations];
        
    }
    
    
    if ([self.delegate respondsToSelector:@selector(showOrHiddenAddChannelsCollectionView:)]) {
        [self.delegate showOrHiddenAddChannelsCollectionView:button];
    }
//    [self.editBtn setSelected:NO];
//    self.editBtn.backgroundColor=[UIColor clearColor];
    
}

-(void)editBtnOnClick:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    if ([btn isSelected]) {
        
        [btn setSelected:NO];
        [btn setBackgroundColor:[UIColor clearColor]];
        if ([self.delegate respondsToSelector:@selector(editCompletedPressed)]) {
            [self.delegate editCompletedPressed];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(editBtnPressed)]) {
            [self.delegate editBtnPressed];
        }
         [btn setBackgroundColor:[CommData shareInstance].skinColor];
        [btn setSelected:YES];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
   // scrollView_.frame = self.bounds;
    [self layoutTabbar];
}

- (void)layoutTabbar{
//    float width = self.bounds.size.width/self.tabbarItems.count;
//    float height = self.bounds.size.height;
//    float x = 0.0f;
//    for (NSInteger i=0; i<self.tabbarItems.count; i++) {
//        x = i*width;
//        UILabel *label = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+i];
//        UIImageView *imageView = (UIImageView *)[scrollView_ viewWithTag:kImageTagBase+i];
//        UIImageView *selectedIamgeView = (UIImageView *)[scrollView_ viewWithTag:kSelectedImageTagBase+i];
//        label.frame = CGRectMake(x + (width-label.bounds.size.width-CGRectGetWidth(imageView.bounds))/2.0f, (height-label.bounds.size.height)/2.0f, CGRectGetWidth(label.bounds), CGRectGetHeight(label.bounds));
//        imageView.frame = CGRectMake(label.frame.origin.x + label.bounds.size.width+kImageSpacingX, (height-imageView.bounds.size.height)/2.0, CGRectGetWidth(imageView.bounds), CGRectGetHeight(imageView.bounds));
//        selectedIamgeView.frame = imageView.frame;
//    }
    
//    float trackX = width*self.selectedIndex;
//    trackView_.frame = CGRectMake(trackX, trackView_.frame.origin.y, width, kTrackViewHeight);
}

- (NSInteger)tabbarCount{
    return self.tabbarItems.count;
}

- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent{
    //DLScrollTabbarItem *fromItem = [self.tabbarItems objectAtIndex:fromIndex];
    UILabel *fromLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+fromIndex];
    fromLabel.textColor = [DLUtility getColorOfPercent:percent between:self.tabItemNormalColor and:self.tabItemSelectedColor];
    
    UILabel *toLabel = nil;
    if (toIndex >= 0 && toIndex < [self tabbarCount]) {
        //DLScrollTabbarItem *toItem = [self.tabbarItems objectAtIndex:toIndex];
        toLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+toIndex];
        toLabel.textColor = [DLUtility getColorOfPercent:percent between:self.tabItemSelectedColor and:self.tabItemNormalColor];
    }
    
    // 计算track view位置和宽度
    CGRect fromRc = [scrollView_ convertRect:fromLabel.bounds fromView:fromLabel];
    CGFloat fromWidth = fromLabel.frame.size.width;
    CGFloat fromX = fromRc.origin.x;
    CGFloat toX;
    CGFloat toWidth;
    if (toLabel) {
        CGRect toRc = [scrollView_ convertRect:toLabel.bounds fromView:toLabel];
        toWidth = toRc.size.width;
        toX = toRc.origin.x;
    }
    else{
        toWidth = fromWidth;
        if (toIndex > fromIndex) {
            toX = fromX + fromWidth;
        }
        else{
            toX = fromX - fromWidth;
        }
    }

    CGFloat width = toWidth * percent + fromWidth*(1-percent);
    CGFloat x = fromX + (toX - fromX)*percent;
    trackView_.frame = CGRectMake(x, trackView_.frame.origin.y, width, CGRectGetHeight(trackView_.bounds));
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (_selectedIndex != selectedIndex) {
        if (_selectedIndex >= 0) {
            //DLScrollTabbarItem *fromItem = [self.tabbarItems objectAtIndex:_selectedIndex];
            UILabel *fromLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+_selectedIndex];
            
            fromLabel.textColor = self.tabItemNormalColor;
            
            [UIView animateWithDuration:0.25 animations:^{
                fromLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:self.tabItemNormalFontSize];
            }];
        }
        
        if (selectedIndex >= 0 && selectedIndex < [self tabbarCount]) {
            //DLScrollTabbarItem *toItem = [self.tabbarItems objectAtIndex:selectedIndex];
            UILabel *toLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+selectedIndex];
            toLabel.textColor = self.tabItemSelectedColor;
            
           
            UIView *selectedView = [scrollView_ viewWithTag:kViewTagBase+selectedIndex];
            //CGRect selectedRect = selectedView.frame;
            
           
            CGRect rc = selectedView.frame;
            //选中的居中显示
            rc = CGRectMake(CGRectGetMidX(rc) - scrollView_.bounds.size.width/2.0f, rc.origin.y, scrollView_.bounds.size.width, rc.size.height);
            
           
            
// 滚动左右两格到可见位置
//            if (selectedIndex > 0) {
//                UIView *leftView = [scrollView_ viewWithTag:kViewTagBase+selectedIndex-1];
//                rc = CGRectUnion(rc, leftView.frame);
//            }
//            if (selectedIndex < [self tabbarCount]-1) {
//                UIView *rightView = [scrollView_ viewWithTag:kViewTagBase+selectedIndex+1];
//                rc = CGRectUnion(rc, rightView.frame);
//            }
            [scrollView_ scrollRectToVisible:rc animated:YES];
            
            // track view
            CGRect trackRc = [scrollView_ convertRect:toLabel.bounds fromView:toLabel];
            
            
            [UIView animateWithDuration:0.25 animations:^{
                toLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:self.tabItemSelectedFontSize];
                 trackView_.frame = CGRectMake(trackRc.origin.x, trackView_.frame.origin.y, trackRc.size.width, CGRectGetHeight(trackView_.bounds));
               
                
            }];
        }
        
//        float width = self.bounds.size.width/self.tabbarItems.count;
//        float trackX = width*selectedIndex;
//        trackView_.frame = CGRectMake(trackX, trackView_.frame.origin.y, CGRectGetWidth(trackView_.bounds), CGRectGetHeight(trackView_.bounds));
        
        _selectedIndex = selectedIndex;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSInteger i = tap.view.tag - kViewTagBase;
    self.selectedIndex = i;
    if (self.delegate) {
        [self.delegate DLSlideTabbar:self selectAt:i];
    }
}


#pragma mark - 计算label 宽度
-(CGSize)caculateLabelHeight:(NSString *)str  withFont:(UIFont *)font{
    
    //计算字符串在label上的高度
    
    CGSize labelSize= [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil]];
    
    
    return labelSize;
}
@end
