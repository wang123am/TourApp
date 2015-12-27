//
//  XMSetTravelRootController.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//


#import "XMSetTravelRootController.h"
#import "XMSelectData.h"
#import "XMDestinationView.h"
#import "UIView+XM.h"
#import "XMSelectCity.h"
#import "XMCalendar.h"
#import "XMSetTourButton.h"
#import "XMCalendar.h"
#import "XMSetTravelTool.h"
#import "XMSetTravelDB.h"
#import "XMTimer.h"
#import "XMTravelassistantDb.h"
#define viewWidth  self.view.frame.size.width
#define viewHeight self.view.frame.size.height
#define textMargin 20
#define viewMargin 1
#define titleHeight 20
#define selectWidth viewWidth-2*textMargin
#define selectHeight 50

@interface XMSetTravelRootController()<XMSelectCityDelegate,XMSelectCityDelegate,XMCalendarDelegate>
/** 设置行程滚动器*/
@property (nonatomic,weak) UIScrollView *scroller;
/** 出发点内容最高值*/
@property (nonatomic,assign)CGFloat startPointMaxY;
/** 目的地内容最高值*/
@property (nonatomic,assign)CGFloat endPointMaxY;
/** 开始旅游按钮最高值*/
@property (nonatomic,assign)CGFloat endMaxY;
/** 开始目的地*/
@property (nonatomic,weak) XMSelectData *startPointSelect;
/** 开始选中日期*/
@property (nonatomic,weak) XMSelectData *startDateSelect;
/** 结束目的地*/
@property (nonatomic,weak) XMDestinationView *endPointSelect;

/**
 *  记录回调信息
 */
@property (nonatomic,copy) NSString * startPoint;
@property (nonatomic,copy) NSString * startDate;
@property (nonatomic,copy) NSString * endPoint;
@property (nonatomic,copy) NSString * endFromDate;
@property (nonatomic,copy) NSString * endToDate;
@end

@implementation XMSetTravelRootController

-(void)viewDidLoad
{
    [super viewDidLoad];
    //1.设置导航栏信息
    [self setUpNavgationData];
    //2.添加页面内容
    [self addChildViewData];
    
}

#pragma mark -设置导航
-(void) setUpNavgationData
{
    //设置标题
    self.navigationItem.title = @"设置行程";
}

#pragma mark -添加子控件
-(void) addChildViewData
{
    //1.添加滚动器到view
    UIScrollView *scroller = [[UIScrollView alloc] init];
    self.scroller = scroller;
    scroller.frame = self.view.frame;
    [self.view addSubview:scroller];
    [scroller setBackgroundColor:navigationBg];
    //2.添加选择出发地到scroller
    [self addstartPoint];
    
    //3.添加选择目的地到scroller
    [self addDestination];
    
    //4.添加开始旅游按钮
    [self addStartTourButton];
    
    //5.设置滚动器属性
    self.scroller.contentSize = CGSizeMake(0, self.endMaxY);
}

/**
 *  添加出发地子控件
 */
-(void) addstartPoint
{
    //1.添加标题
    UILabel *startLabel = [self addPointTitle:@"选择出发地"];
    startLabel.frame = CGRectMake(textMargin, textMargin, self.view.frame.size.width, titleHeight);
    //2.添加当前位置
    XMSelectData *startPointSelect = [[XMSelectData alloc] initWithLeftImg:[UIImage imageNamed:@"travel_page_listitem_first"] leftText:@"当前位置" rightText:@"请选择" rightImg:[UIImage imageNamed:@"travel_page_listitem_right_icon_arrow"]];
    CGFloat startPointSelectY = CGRectGetMaxY(startLabel.frame) + textMargin;
    startPointSelect.frame = CGRectMake(textMargin, startPointSelectY, selectWidth, selectHeight);
    [startPointSelect OnViewClickListener:self action:@selector(onStartPointClick)];
    [self.scroller addSubview:startPointSelect];
    self.startPointSelect = startPointSelect;
    //3.添加日期
    XMSelectData *startPointDate = [[XMSelectData alloc] initWithLeftImg:[UIImage imageNamed:@"travel_page_calendar_left_icon"] leftText:@"出发日期" rightText:[XMTimer toDay] rightImg:[UIImage imageNamed:@"travel_page_listitem_right_icon_arrow"]];
    [startPointDate OnViewClickListener:self action:@selector(startPointDateClick)];
    CGFloat startPointDateY = CGRectGetMaxY(startPointSelect.frame) + viewMargin;
    startPointDate.frame = CGRectMake(textMargin, startPointDateY, selectWidth, selectHeight);
    [self.scroller addSubview:startPointDate];
    self.startDateSelect = startPointDate;
    self.startDate = startPointDate.rightLabel.text;
    //记录选择出发地最大Y值
    self.startPointMaxY = CGRectGetMaxY(startPointDate.frame);
}

/**
 *  添加目的地子控件
 */
-(void)addDestination
{
    CGFloat marginStartPoint = 50;
    //1.添加标题
    UILabel *endLabel = [self addPointTitle:@"选择目的地"];
    endLabel.frame = CGRectMake(textMargin, self.startPointMaxY + marginStartPoint, 100, titleHeight);
    
    //2.添加目的地位置
    CGFloat destinationViewY = CGRectGetMaxY(endLabel.frame) + textMargin;
    XMDestinationView *destinationView = [[XMDestinationView alloc] initWithFrame:CGRectMake(textMargin, destinationViewY, selectWidth, 2 * selectHeight)];
    [self.scroller addSubview:destinationView];
    self.endPointSelect = destinationView;
    self.endFromDate = destinationView.fromDateView.text;
    self.endToDate = destinationView.toDateView.text;
    //设置出发地和日期的点击事件
    [destinationView.selectCity OnViewClickListener:self action:@selector(onEndPointClick)];
    [destinationView.fromDateView OnViewClickListener:self action:@selector(fromDateClick)];
    [destinationView.toDateView OnViewClickListener:self action:@selector(toDateClick)];
    
    //记录选择目的地最大Y值
    self.endPointMaxY = CGRectGetMaxY(destinationView.frame);
}

/**
 *  添加开始旅游按钮
 */
-(void)addStartTourButton
{
    XMSetTourButton *startTourButton = [XMSetTourButton buttonWithTitle:@"开始旅游" normalImg:[UIImage imageNamed:@"travel_page_start_travel"] presseed:[UIImage imageNamed:@"travel_page_start_travel_pressed"] isEnableImg:true];
    self.startTourButton = startTourButton;
    startTourButton.frame = CGRectMake(textMargin, self.endPointMaxY+textMargin, selectWidth, selectHeight);
    [startTourButton addTarget:self action:@selector(startTourButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scroller addSubview:startTourButton];
    
    //记录最终内容最大Y值
    self.endMaxY = CGRectGetMaxY(startTourButton.frame);
}

/**
 *  添加起点，终点标题
 */
-(UILabel *)addPointTitle:(NSString *)title
{
    UILabel *pointText = [[UILabel alloc] init];
    pointText.text = title;
    pointText.font = [UIFont systemFontOfSize:13];
    pointText.textColor = [UIColor blackColor];
    [self.scroller addSubview:pointText];
    return pointText;
}

/**
 *  点击出发点
 */
-(void)onStartPointClick
{
    XMSelectCity *cityController = [[XMSelectCity alloc] init];
    cityController.tag = 1;
    cityController.delegate = self;
    [self.navigationController pushViewController:cityController animated:YES];
}
/**
 *  选择出发日期
 */
-(void)startPointDateClick
{
    [self onDateClick:1];
}

-(void)fromDateClick
{
    [self onDateClick:2];
}

-(void)toDateClick
{
    [self onDateClick:3];
}

-(void)onDateClick:(int) tag
{
    XMCalendar *calendar = [[XMCalendar alloc] init] ;
    calendar.tag = tag;
    calendar.delegate = self;
    [self.navigationController pushViewController:calendar animated:YES];
}

/**
 *  选中目的地
 */
-(void)onEndPointClick
{
    if (![self.startPointSelect.rightLabel.text isEqualToString: @"请选择"]) {
        XMSelectCity *cityController = [XMSelectCity new];
        cityController.tag = 2;
        cityController.delegate = self;
        [self.navigationController pushViewController:cityController animated:YES];
    } else {
        //请选择出发点
        [XMSetTravelTool showToast:@"请选择出发点" view:self.view];
    }
}
/**
 *  点击开始旅行
 */
-(void)startTourButtonClick
{
    //存储数据
    XMSetTravelDB *db = [[XMSetTravelDB alloc] init];
    [db saveStartTourWithStartPoint:self.startPoint startDate:self.startDate endPoint:self.endPoint endFromDate:self.endFromDate endToDate:self.endToDate];
    //更改行程助手表
    
    [db upDateTravelassistantWithCity:self.startPoint time:self.startDate cityType:@"出发点"];
    [db upDateTravelassistantWithCity:self.endPoint time:self.endFromDate cityType:@"目的地"];
    
    if ([self.delegate respondsToSelector:@selector(setTravelCallBack:startDate:endPoint:endFromDate:endToDate:)]) {
        [self.delegate setTravelCallBack:self.startPoint startDate:self.startDate endPoint:self.endPoint endFromDate:self.endFromDate endToDate:self.endToDate];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -代理返回的值
-(void)selectCityCallBackWithCity:(NSString *)city controllerTag:(int)tag
{
    if (tag == 1) {
        //点击的是出发点
        self.startPointSelect.rightLabel.text = city;
        self.startPoint = city;
    } else if (tag == 2){
        //点击的是目的地
        self.endPointSelect.selectCity.rightLabel.text = city;
        self.startTourButton.enabled = YES;
        self.endPoint = city;
    }
}

/**
 *  日期回调
 */
-(void)seletorDateCallBack:(NSString *)date viewTag:(int)tag
{
    if (tag == 1) {
        self.startDateSelect.rightLabel.text = date;
        self.startDate = date;
    } else if (tag == 2) {
        NSString *startDateStr = [self.startDateSelect.rightLabel.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
        NSString *fromDateStr = [date stringByReplacingOccurrencesOfString:@"/" withString:@""];
        if ([fromDateStr intValue] < [startDateStr intValue]) {
            [XMSetTravelTool showToast:@"日期不正确" view:self.view];
        } else {
            self.endPointSelect.fromDateView.text = date;
            self.endFromDate = date;
        }
    } else if (tag == 3) {
        NSString *toDateStr = [self.endPointSelect.fromDateView.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
        NSString *fromDateStr =[date stringByReplacingOccurrencesOfString:@"/" withString:@""];
        if ([toDateStr intValue] > [fromDateStr intValue]) {
            //日期不正确
            [XMSetTravelTool showToast:@"日期不正确" view:self.view];
        } else {
            self.endPointSelect.toDateView.text = date;
            self.endToDate = date;
        }

    }
}


@end
