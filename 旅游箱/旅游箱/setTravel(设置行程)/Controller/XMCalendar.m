//
//  XMCalendar.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/8.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMCalendar.h"
#import "LKCalendarDefine.h"
#import "XMTimer.h"
#import "XMAccountDb.h"

#define viewWidth self.view.frame.size.width
#define navigationBg [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]
@interface XMCalendar ()<LKCalendarMonthDelegate,LKCalendarDayViewDelegate,LKCalendarViewDelegate>
@property(strong,nonatomic)LKCalendarView* calendarView;
@property(weak,nonatomic)LKCalendarDayView* lastSelectedDayView;
@property(strong,nonatomic)UILabel* lb_show;
@property(strong,nonatomic)UIImageView* weekNameView;
//存储年份和月份,返回给上一个控制器
@property(copy,nonatomic)NSString *seletorDate;
@end

@implementation XMCalendar

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = navigationBg;
    //1.添加年份的view
    self.lb_show = [[UILabel alloc]initWithFrame:CGRectMake(0,80, viewWidth, 30)];
    _lb_show.font = [UIFont systemFontOfSize:18];
    _lb_show.textColor = [UIColor redColor];
    _lb_show.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_lb_show];
    //2.添加星期的view
    self.weekNameView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lb_show.frame) + 20., viewWidth, 20)];
    [self.weekNameView setImage:[UIImage imageNamed:@"wq_calendar_weekly_header"]];
    [self.view addSubview:_weekNameView];
    //3.添加日历的view
    self.calendarView = [[LKCalendarView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekNameView.frame), viewWidth, SYCC_MonthHeight)];
    _calendarView.currentDateComponents = getYearMonthDateComponents([NSDate date]);
    [_calendarView startLoadingView];
    [self.view addSubview:_calendarView];
    _calendarView.delegate  = self;
    
    [self calendarViewDidChangedMonth:_calendarView];
}
/**
 *  日历改变月份时调用，用于更行显示日历月份的label
 */
-(void)calendarViewDidChangedMonth:(LKCalendarView *)sender
{
    long year = sender.currentDateComponents.year;
    long month = sender.currentDateComponents.month;
    _lb_show.text = [NSString stringWithFormat:@"%ld年%02ld月",year,month];
    self.seletorDate = [NSString stringWithFormat:@"%ld/%02ld",year,month];
}
-(void)calendarMonth:(LKCalendarMonth *)month dayView:(LKCalendarDayView *)dayView date:(NSDate *)date
{
    long monthdiff = monthDiffWithDateComponents(month.currentMonth,getYearMonthDateComponents(date));
    //判断日期是否是今天
    if ([XMTimer isToday:date]) {
        dayView.backgroundColor = [UIColor lightGrayColor];
    }else {
        dayView.backgroundColor = [UIColor whiteColor];
    }
    dayView.date = date;
    dayView.lb_date.hidden = (monthdiff != 0);
}
/**
 *  日期选中时调用
 */
-(void)calendarDayViewWillSelected:(LKCalendarDayView *)dayView
{
    if([_lastSelectedDayView isEqual:dayView])
        return;
    
    if(_lastSelectedDayView){
        _lastSelectedDayView.selected = NO;
        
    }
    
    _lastSelectedDayView = dayView;
    long monthdiff = monthDiffWithDateComponents(_calendarView.currentDateComponents,getYearMonthDateComponents(dayView.date));
    if(monthdiff != 0)
    {
//        dayView.selected = NO;
//        LKCalendarDayView* selectedView = [_calendarView moveToDate:dayView.date];
//        
//        selectedView.selected = YES;
//        _lastSelectedDayView = selectedView;
        return;
    }
    int dateInt = [dayView.lb_date.text intValue];
    //返回时间
    if ([self.delegate respondsToSelector:@selector(seletorDateCallBack: viewTag:)]) {
   
        NSString *dateStr = [NSString stringWithFormat:@"%02d",dateInt];
        NSString *dateString = [NSString stringWithFormat:@"%@/%@",self.seletorDate,dateStr];
        [self.delegate seletorDateCallBack:dateString viewTag:self.tag];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

@end
