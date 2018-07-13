//
//  PDMISegmentTabBarView.m
//  News
//
//  Created by pdmi on 2017/7/5.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//

#import "PDMISegmentTabBarView.h"

#import "UIView+Frame.h"


@interface PDMISegmentTabBarView()

@property (nonatomic, strong) UIView *frontLabelbgView;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation PDMISegmentTabBarView



-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}




-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
       // [self setUpUI];
    }
    return self;
}



-(void)setUpUI{
    
    CGFloat width = self.frame.size.width/self.tabbarItems.count;
    CGFloat height = self.frame.size.height;
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = (self.borderColor?self.borderColor:[UIColor grayColor]).CGColor;
    self.layer.cornerRadius =  height/2;
    self.bgView.clipsToBounds = YES;
    
    for (int i = 0;i<self.tabbarItems.count; i++) {
        PDMITagItem *item=[self.tabbarItems objectAtIndex:i];
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.userInteractionEnabled = YES;
        titleLb.tag = 1000+i;
        titleLb.text = item.columnTitle;
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.textColor = self.normalLabelColor?self.normalLabelColor:[UIColor blackColor];
        titleLb.font = [UIFont systemFontOfSize:14];
        titleLb.frame = CGRectMake(width*i,0, width, height);
        titleLb.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedLabel:)];
        [titleLb addGestureRecognizer:tap];
        [self addSubview:titleLb];
    }
    
    self.bgView.frame = CGRectMake(0, 0, width, height);
    _bgView.backgroundColor = self.selectedViewColor?self.selectedViewColor:[UIColor grayColor];
    self.bgView.layer.cornerRadius = height/2;
    self.bgView.clipsToBounds = YES;
    [self addSubview:self.bgView];
    
    
    UIView *topLabelView = [[UIView alloc]initWithFrame:self.bounds];
    topLabelView.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:topLabelView];
    self.frontLabelbgView = topLabelView;
    
    
    for (int i = 0;i<self.tabbarItems.count; i++) {
        PDMITagItem *item=[self.tabbarItems objectAtIndex:i];

        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.userInteractionEnabled = YES;
        titleLb.text = item.columnTitle;
        titleLb.backgroundColor =self.selectedViewColor?self.selectedViewColor:[UIColor grayColor];
      
         titleLb.textColor = self.selectTextColor?self.selectTextColor:[UIColor grayColor];
        titleLb.font = [UIFont systemFontOfSize:14];
        titleLb.frame = CGRectMake(width*i,0, width, height);
        titleLb.textAlignment = NSTextAlignmentCenter;
        [topLabelView addSubview:titleLb];
    }
    
}


-(void)selectedLabel:(UITapGestureRecognizer *)sender{
    
    CGFloat width = self.frame.size.width/self.tabbarItems.count;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.left = (sender.view.tag - 1000)*width;
        self.frontLabelbgView.left = -(sender.view.tag - 1000)*width;
        [self.bgView layoutIfNeeded];
    }];
    
    NSInteger i = sender.view.tag - 1000;
    self.selectedIndex = i;
    if ([self respondsToSelector:@selector(selectedLabel:)]) {
        //[self.delegate dw_segmentedControl:self didSeletRow:sender.view.tag - 1000];
        [self.delegate DLSlideTabbar:self selectAt:i];
    }
    
}
-(void)setTabbarItems:(NSArray *)tabbarItems{
    if (tabbarItems) {
        _tabbarItems=tabbarItems;
        [self removeFromSuperview];
        [self setUpUI];
    }
}

//-(void)setTitles:(NSArray<NSString *> *)titles{
//    if (titles) {
//        _tabbarItems = titles;
//        [self removeFromSuperview];
//        [self setUpUI];
//    }
//}
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent{
    if (toIndex >= 0 && toIndex< self.tabbarItems.count&&toIndex!=_selectedIndex)
    {
        CGFloat width = self.frame.size.width/self.tabbarItems.count;
        [UIView animateWithDuration:0.3 animations:^{
            self.bgView.left = toIndex*width;
            self.frontLabelbgView.left = -toIndex*width;
            [self.bgView layoutIfNeeded];
        }];
        
        if (_selectedIndex != toIndex) {
            _selectedIndex = toIndex;
            
        }

    }
    
   
    
   }
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (_selectedIndex != selectedIndex) {
        
        if (selectedIndex >= 0 && selectedIndex < self.tabbarItems.count)
            {
                
        [self switchingFrom:0 to:selectedIndex percent:0];
            }
        
    }
}


@end
