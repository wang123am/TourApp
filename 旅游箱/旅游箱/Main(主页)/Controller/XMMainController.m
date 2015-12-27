//
//  XMMainController.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMMainController.h"
#import "XMMainScroller.h"
#import "XMSetTravelRootController.h"
#import "XMNavigationController.h"
#import "XMMainDb.h"
#import "XMTopScroller.h"
#import "XMWeatherRootController.h"
#import "XMTranslateRootController.h"
#import "XMExrateRootController.h"
#import "XMAccountRootController.h"
#import "XMSettingRootController.h"
#import "XMTravelassistantRootController.h"

#define appWidth self.view.frame.size.width
#define topBgHight self.view.frame.size.height * 0.6

@interface XMMainController() <UIScrollViewDelegate,XMTopScrollerDelegate,XMMainScrollerDelegate>
/** 顶部背景图片*/
@property (nonatomic,weak) UIImageView *topBg;
/** 顶部开始旅游按钮*/
@property (nonatomic,weak) UIButton *startTour;
/** 顶部滚动时钟*/
@property (nonatomic,weak) XMTopScroller *topScroller;
/** 底部背景图片*/
@property (nonatomic,weak) UIImageView *buttomBg;
/** 底部滚动导航*/
@property (nonatomic,weak) UIScrollView *buttomScroll;
/** 装载导航按钮文字*/
@property (nonatomic,strong) NSArray *gridItemText;
/** 数据库*/
@property (nonatomic,strong) XMMainDb *db;

@end

@implementation XMMainController

-(void)viewDidLoad
{
    //1.设置旅程头部
    [self setUpTourTopView];
    //2.设置旅程底部
    [self setUpTourButtomView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -加载导航按钮文字
-(NSArray *)gridItemText
{
    if(_gridItemText == nil)
    {
        _gridItemText = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gridItemText" ofType:@"plist"]];
    }
    return _gridItemText;
}

/**
 *  1.设置旅程头部
 */
#pragma mark 设置头部
-(void)setUpTourTopView
{
    //顶部背景
    UIImageView *topBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_page_top_day_bg"]];
    self.topBg = topBg;
    topBg.userInteractionEnabled = YES;
    topBg.frame = CGRectMake(0, 0, appWidth, topBgHight);
    [self.view addSubview:topBg];
    
    //添加背景内部图片
    [self addStartTourButton];
    //添加时钟
    [self addTopClock];
}

/**
 *  添加顶部开始设置旅游按钮
 */
-(void)addStartTourButton
{
    UIButton *startTour = [[UIButton alloc] init];
    self.startTour = startTour;
    [startTour setImage:[UIImage imageNamed:@"main_page_top_set"] forState:UIControlStateNormal];
    //设置frame
    CGFloat startTourW = appWidth - 20;
    CGFloat startTourY = topBgHight - 120;
    startTour.frame = CGRectMake((appWidth - startTourW) * 0.5,startTourY,startTourW,topBgHight - startTourY * 2);
    
    //点击事件
    [startTour addTarget:self action:@selector(OnClickstartTour) forControlEvents:UIControlEventTouchUpInside];
    [self.topBg addSubview:startTour];
}

/**
 *  添加时钟
 */
-(void) addTopClock
{
    //创建滚动条
    XMTopScroller *topScroller = [[XMTopScroller alloc] initWithFrame:CGRectMake(0, 0, appWidth, topBgHight)];
    topScroller.hidden = YES;
    topScroller.delegate = self;
    self.topScroller = topScroller;
    [self.topBg addSubview:topScroller];
    
}

-(void)selectCity
{
    XMMainDb *db = [[XMMainDb alloc] init];
    self.db = db;
    if ([db isSetupCity]) {
        NSMutableDictionary *dict = [db selectCity];
        [self showClock:db startPoint:dict[@"startPoint"] endPoint:dict[@"endPoint"]];
        int hour = [self.topScroller.nowTime[@"hour"] intValue];
        if (hour > 18 || hour < 6) {
            [self.topBg setImage:[UIImage imageNamed:@"main_page_top_night_bg"]];
            self.topScroller.leftCity.textColor = [UIColor whiteColor];
            self.topScroller.rightCity.textColor = [UIColor whiteColor];
            self.topScroller.leftDate.textColor = [UIColor whiteColor];
            self.topScroller.rightDate.textColor = [UIColor whiteColor];
        }
    } else {
        self.startTour.hidden = NO;
        self.topScroller.hidden = YES;
    }
}

-(void)showClock:(XMMainDb *)db startPoint:(NSString *)startPoint endPoint:(NSString *)endPoint
{
    self.startTour.hidden = YES;
    self.topScroller.hidden = NO;

    //查询时差
    NSString *startCityClock = [db selectClockWithCity:startPoint];
    NSString *endCityClock = [db selectClockWithCity:endPoint];
    //设置数据
    self.topScroller.leftClock.clockJetLag = 8 - [startCityClock intValue];
    self.topScroller.rightClock.clockJetLag = 8 - [endCityClock intValue];
    //设置城市
    self.topScroller.leftCity.text = startPoint;
    self.topScroller.rightCity.text = endPoint;
}

/**
 *  2.设置旅程底部
 */
#pragma mark 设置底部
-(void)setUpTourButtomView
{
    //1.底部背景
    [self addButtomBackground];
    
    //2.添加scrollView滚动目录
    [self addScrollToButtomBg];
}

/**
 *  添加底部背景
 */
#pragma mark -添加底部背景
-(void)addButtomBackground
{
    UIImageView *buttomBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_page_bottom_bg"]];
    //设置可被用户交互
    buttomBg.userInteractionEnabled = YES;
    buttomBg.frame = CGRectMake(0, topBgHight, appWidth, self.view.frame.size.height - topBgHight);
    [self.view addSubview:buttomBg];
    self.buttomBg = buttomBg;
}

/**
 *  添加滚动导航到底部背景
 */
#pragma mark -添加滚动导航
-(void)addScrollToButtomBg
{
    //间距
    CGFloat buttomScrollMargin = 10;
    CGFloat buttomScrollH = self.buttomBg.frame.size.height - 70;
    XMMainScroller *buttomScroll = [[XMMainScroller alloc] initWithFrame:CGRectMake(0, buttomScrollMargin, appWidth, buttomScrollH) titleArray:self.gridItemText];
    [self.buttomBg addSubview:buttomScroll];
    buttomScroll.delegate = self;
    self.buttomScroll = buttomScroll;
}

#pragma mark 点击头部
-(void)OnClickstartTour
{
    XMSetTravelRootController *rootController = [[XMSetTravelRootController alloc ]init];
    XMNavigationController *setTraveController = [[XMNavigationController alloc] initWithRootViewController:rootController];
    [self presentViewController:setTraveController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //3.判断数据库是否有设置城市信息
    [self selectCity];
}

/**
 *  点击重新设置按钮时调用
 */
-(void)resetButtonClick
{
    //删除数据库内容
    XMMainDb *db = [[XMMainDb alloc] init];
    BOOL flag = [db deleteCityData];
    if (flag) {
        self.topScroller.hidden = YES;
        self.startTour.hidden = NO;
    }
}

-(void)onMainItemClick:(long)viewTag
{
    XMBaseViewController *baseController = nil;
    switch (viewTag) {
            //行程天气
        case 0:
            baseController = [[XMWeatherRootController alloc]init];
            break;
            //实时翻译
        case 1:
            baseController = [[XMTranslateRootController alloc] init];
            break;
            //行程助手
        case 2:
            baseController = [[XMTravelassistantRootController alloc] init];
            break;
            //记账本
        case 3:
            baseController = [[XMAccountRootController alloc] init];
            break;

            //汇率换算
        case 4:
            baseController = [[XMExrateRootController alloc] init];
            break;

            //更多设置
        case 5:
            baseController = [[XMSettingRootController alloc]init];
            break;
    }
    XMNavigationController *navigation = [[XMNavigationController alloc] initWithRootViewController:baseController];
    [self presentViewController:navigation animated:YES completion:nil];
}
@end
