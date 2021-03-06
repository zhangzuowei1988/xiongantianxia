//
//  XAselectDatePicker.m
//  News
//
//  Created by mac on 2018/5/9.
//  Copyright © 2018年 pdmcom.pdmi.test. All rights reserved.
//

#import "XASelectDatePicker.h"

@interface XASelectDatePicker ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger yearIndex;
    
    NSInteger monthIndex;
    
    NSInteger dayIndex;
    
    UIView *topV;
}
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *yearArray;

@property (nonatomic, strong) NSMutableArray *monthArray;

@property (nonatomic, strong) NSMutableArray *dayArray;

@end

@implementation XASelectDatePicker
- (NSMutableArray *)yearArray {
    
    if (_yearArray == nil) {
        
        _yearArray = [NSMutableArray array];
        
        for (int year = 1900; year < 2050; year++) {
            
            NSString *str = [NSString stringWithFormat:@"%d年", year];
            
            [_yearArray addObject:str];
        }
    }
    
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    
    if (_monthArray == nil) {
        
        _monthArray = [NSMutableArray array];
        
        for (int month = 1; month <= 12; month++) {
            
            NSString *str = [NSString stringWithFormat:@"%02d月", month];
            
            [_monthArray addObject:str];
        }
    }
    
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    
    if (_dayArray == nil) {
        
        _dayArray = [NSMutableArray array];
        
        for (int day = 1; day <= 31; day++) {
            
            NSString *str = [NSString stringWithFormat:@"%02d日", day];
            
            [_dayArray addObject:str];
        }
    }
    
    return _dayArray;
}


- (instancetype)init
{
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    if (self) {
        UITapGestureRecognizer *gestureRecoginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureTap)];
        [self addGestureRecognizer:gestureRecoginzer];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        
        topV = [[UIView alloc] initWithFrame:CGRectMake(0, screenSize.height, ScreenWidth, 40)];
        topV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:10];
        [self addSubview:topV];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, 100, 40);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [topV addSubview:cancelBtn];
        
        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake(ScreenWidth - 100, 0, 100, 40);
        [yesBtn setTitle:@"完成" forState:UIControlStateNormal];
        [yesBtn setTitleColor:[CommData shareInstance].skinColor forState:UIControlStateNormal];
        [yesBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [topV addSubview:yesBtn];
        [cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [yesBtn addTarget:self action:@selector(yesButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, topV.bottom, ScreenWidth, 207)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
        unsigned unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        // 获取不同时间字段的信息
        NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
        
        yearIndex = [self.yearArray indexOfObject:[NSString stringWithFormat:@"%ld年", comp.year-30]];
        monthIndex = [self.monthArray indexOfObject:[NSString stringWithFormat:@"%02ld月", comp.month]];
        dayIndex = [self.dayArray indexOfObject:[NSString stringWithFormat:@"%02ld日", comp.day]];
        
        [_pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [_pickerView selectRow:monthIndex inComponent:1 animated:YES];
        [_pickerView selectRow:dayIndex inComponent:2 animated:YES];
        
        [self pickerView:_pickerView didSelectRow:yearIndex inComponent:0];
        [self pickerView:_pickerView didSelectRow:monthIndex inComponent:1];
        [self pickerView:_pickerView didSelectRow:dayIndex inComponent:2];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[_pickerView viewForRow:yearIndex forComponent:0];
            label.textColor = [UIColor blackColor];//setRGBColor(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
            
            label = (UILabel *)[_pickerView viewForRow:monthIndex forComponent:1];
            label.textColor = [UIColor blackColor];//setRGBColor(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
            
            label = (UILabel *)[_pickerView viewForRow:dayIndex forComponent:2];
            label.textColor = [UIColor blackColor];//setRGBColor(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
            
        });
        
        [UIView animateWithDuration:0.25 animations:^{
            
            topV.frame = CGRectMake(0, screenSize.height - 247, ScreenWidth, 40);
            _pickerView.frame = CGRectMake(0, topV.bottom, ScreenWidth, 207);
        }];
        
    }
    return self;
}

#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
        
    }else if(component == 1) {
        
        return self.monthArray.count;
        
    }else {
        
        switch (monthIndex + 1) {
                
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: return 31;
                
            case 4:
            case 6:
            case 9:
            case 11: return 30;
                
            default: return 28;
        }
    }
}


- (void)remove {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        topV.frame = CGRectMake(0, screenSize.height, ScreenWidth, 40);
        _pickerView.frame = CGRectMake(0, topV.bottom, ScreenWidth, 207);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}
#pragma mark -UIPickerView的代理

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        yearIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor =[UIColor blackColor];// setRGBColor(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
            
        });
        
    }else if (component == 1) {
        
        monthIndex = row;
        
        [pickerView reloadComponent:2];
        
        
        if (monthIndex + 1 == 4 || monthIndex + 1 == 6 || monthIndex + 1 == 9 || monthIndex + 1 == 11) {
            
            if (dayIndex + 1 == 31) {
                
                dayIndex--;
            }
        }else if (monthIndex + 1 == 2) {
            
            if (dayIndex + 1 > 28) {
                dayIndex = 27;
            }
        }
        [pickerView selectRow:dayIndex inComponent:2 animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor =[UIColor blackColor];// setRGBColor(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
            
            label = (UILabel *)[pickerView viewForRow:dayIndex forComponent:2];
            label.textColor =[UIColor blackColor];// setRGBColor(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
            
        });
    }else {
        
        dayIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor =[UIColor blackColor];// setRGBColor(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
            
        });
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //    //设置分割线的颜色
    //    for(UIView *singleLine in pickerView.subviews)
    //    {
    //        if (singleLine.frame.size.height < 1)
    //        {
    //            singleLine.backgroundColor = kSingleLineColor;
    //        }
    //    }
    
    //设置文字的属性
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.textColor = setRGBColor(153, 153, 153, 1.0);
    genderLabel.font = [UIFont systemFontOfSize:14];
    if (component == 0) {
        
        genderLabel.text = self.yearArray[row];
        
    }else if (component == 1) {
        
        genderLabel.text = self.monthArray[row];
        
    }else {
        
        genderLabel.text = self.dayArray[row];
    }
    
    return genderLabel;
}
#pragma mark - buttonClick
- (void)cancelButtonClick
{
    if (_block) {
        _block(nil);
    }
    
    [self remove];

}
- (void)yesButtonClick
{
    if (_block) {
        
        NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",((UILabel *)[_pickerView viewForRow:yearIndex forComponent:0]).text, ((UILabel *)[_pickerView viewForRow:monthIndex forComponent:1]).text, ((UILabel *)[_pickerView viewForRow:dayIndex forComponent:2]).text];
        
        
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
        
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
        
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
        
        _block(timeStr);
        
    }
    [self remove];

}
- (void)gestureTap
{
    
    if (_block) {
        _block(nil);
    }
    [self remove];

}
@end
