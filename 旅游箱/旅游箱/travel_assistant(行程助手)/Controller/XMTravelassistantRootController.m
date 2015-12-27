//
//  XMTravelassistantRootController.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantRootController.h"
#import "XMTravelassistantView.h"
#import "XMSetupCity.h"
#import "XMSetTravelRootController.h"
#import "XMTravelassistantDb.h"
#import "MBProgressHUD+MJ.h"
#import "XMAccountModel.h"
#import "XMAccountRootController.h"
#import "XMTravelassistantModel.h"
#import "XMTravelassistantNoteController.h"
#import "XMTravelassistantTouristController.h"
#import "XMTravelassistantHotelController.h"

#define viewWidth self.view.frame.size.width
#define itemHeight 355
#define cityStartPointType @"startPoint"
#define cityEndPointType @"endPoint"

@interface XMTravelassistantRootController () <XMSetupCityDelegate,XMSetTravelRootDelegate,XMTravelassistantViewDelegate>
/** 滚动条*/
@property (nonatomic,weak) UIScrollView *centerScroller;
/** 出发View*/
@property (nonatomic,weak) XMTravelassistantView *startPointView;
/** 接受View*/
@property (nonatomic,weak) XMTravelassistantView *endPointView;
/** 设置城市*/
@property (nonatomic,weak) XMSetupCity *setupCity;
/** 数据源*/
@property (nonatomic,strong) NSMutableArray *travelassistantArray;
/** 数据库*/
@property (nonatomic,strong) XMTravelassistantDb *travelassistantDb;
@end

@implementation XMTravelassistantRootController

-(NSMutableArray *)travelassistantArray
{
    if (!_travelassistantArray) {
        //先查询更改今天消费。
        NSDictionary *dict = [self.travelassistantDb selectTourDate];
        NSString *startMoney = [self calculateAllConsumeWithDate:dict[@"startDate"]];
        NSString *endMoney = [self calculateAllConsumeWithDate:dict[@"endFromDate"]];
        
        //跟新数据库
        [self.travelassistantDb upDateTravelassistantWithMoney:startMoney cityType:@"startPoint"];
        [self.travelassistantDb upDateTravelassistantWithMoney:endMoney cityType:@"endPoint"];
        [self.travelassistantDb upDateTravelassistantWithCity:dict[@"startPoint"] time:dict[@"startDate"] cityType:@"startPoint"];
        [self.travelassistantDb upDateTravelassistantWithCity:dict[@"endPoint"] time:dict[@"endFromDate"] cityType:@"endPoint"];
        //查询设置的城市和日期信息
        _travelassistantArray = [self.travelassistantDb selectTravelassistantData];
    }
    
    return _travelassistantArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"行程助手";
    XMTravelassistantDb *travelassistantDb = [[XMTravelassistantDb alloc] init];
    self.travelassistantDb = travelassistantDb;
    //查询今天消费
    if ([self.travelassistantDb isSetupCity]) {
        [self showTravelassistantView];
    } else {
        [self showSetupCityView];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _travelassistantArray = nil;
    _travelassistantArray = [self.travelassistantDb selectTravelassistantData];
    [self.startPointView setModel:self.travelassistantArray[0]];
    [self.endPointView setModel:self.travelassistantArray[1]];
}
/**
 *  显示现在设置城市界面
 */
-(void)showSetupCityView
{
    XMSetupCity *setupCity = [[XMSetupCity alloc] initWithFrame:self.view.frame];
    self.setupCity = setupCity;
    setupCity.delegate = self;
    [self.view addSubview:setupCity];
}

/**
 *  显示行程助手界面
 */
-(void)showTravelassistantView
{
    //添加scrollerView
    [self setupScrollerView];
    //添加顶部线段
    UIImageView *topLine = [self addScrollerLine];
    topLine.frame = CGRectMake(30, -300, 3, 320);
    
    //添加起点的行程
    XMTravelassistantView *startPointView = [XMTravelassistantView viewWithModel:self.travelassistantArray[0] dayNumber:@"第1天"];
    startPointView.delegate = self;
    startPointView.tag = 1;
    self.startPointView = startPointView;
    startPointView.frame = CGRectMake(10, CGRectGetMaxY(topLine.frame), viewWidth, itemHeight);
    [self.centerScroller addSubview:startPointView];
    
    //添加线条
    UIImageView *centerLine = [self addScrollerLine];
    centerLine.frame = CGRectMake(30, CGRectGetMaxY(startPointView.frame), 3, 20);
    
    //添加终点的行程
    XMTravelassistantView *endPointView = [XMTravelassistantView viewWithModel:self.travelassistantArray[1] dayNumber:@"第2天"];
    endPointView.delegate = self;
    endPointView.tag = 2;
    self.endPointView = endPointView;
    endPointView.frame = CGRectMake(10, CGRectGetMaxY(centerLine.frame), viewWidth, itemHeight);
    [self.centerScroller addSubview:endPointView];
    
    self.centerScroller.contentSize = CGSizeMake(0, CGRectGetMaxY(self.endPointView.frame));
}

-(void)setupScrollerView
{
    UIScrollView *centerScroller = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.centerScroller = centerScroller;
    [self.view addSubview:centerScroller];
}
/**
 *  添加线条
 */
-(UIImageView *)addScrollerLine
{
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.alpha = 0.7;
    lineView.backgroundColor = [UIColor colorWithRed:174/255.0 green:95/255.0 blue:95/255.0 alpha:1];
    [self.centerScroller addSubview:lineView];
    return lineView;
}

/**
 *  计算今天总消费
 */
-(NSString *)calculateAllConsumeWithDate:(NSString *)date
{
    
    NSArray *array = [self.travelassistantDb selectAccountData:date];
    //获取人民币汇率
    NSString *cnyRate = [self.travelassistantDb selectRateWithCode:@"CNY"];
    double resultMoney = 0;
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dict = array[i];
        //获取模型中金额的汇率
        NSString *rate = [self.travelassistantDb selectRateWithCode:dict[@"exrate"]];
        //计算金额结果
        double money = [dict[@"money"] doubleValue] * [cnyRate doubleValue] / [rate doubleValue];
        resultMoney += money;
    }
    NSString *resultStr = [NSString stringWithFormat:@"%f",resultMoney];
    //截取小数点后两位
    NSRange resultRange = [resultStr rangeOfString:@"."];
    return [resultStr substringToIndex:resultRange.location + 3];
}

#pragma mark - 代理回调
/**
 *  点击现在设置
 */
-(void)setupcityNowClick
{
    XMSetTravelRootController *rootController = [[XMSetTravelRootController alloc ]init];
    rootController.delegate = self;
    UINavigationController *setTraveController = [[UINavigationController alloc] initWithRootViewController:rootController];
    [self presentViewController:setTraveController animated:YES completion:nil];
}

/**
 *  点击开始按钮后回调
 */
-(void)setTravelCallBack:(NSString *)startPoint startDate:(NSString *)startDate endPoint:(NSString *)endPoint endFromDate:(NSString *)fromDate endToDate:(NSString *)toDate
{
    [self.setupCity removeFromSuperview];
    [self showTravelassistantView];
    
    //设置界面
    [self.startPointView setupDataWithTime:startDate point:startPoint];
    [self.endPointView setupDataWithTime:fromDate point:endPoint];
}

/**
 *  点击条目时调用
 */
-(void)travelassistantItemClickWithSuperViewId:(NSInteger)superViewId clickViewId:(NSInteger)clickViewId
{
    if (superViewId == 1) {
        
        XMTravelassistantModel *model = self.travelassistantArray[0];
        switch (clickViewId) {
            case 0:
            {
                XMAccountRootController *rootController = [[XMAccountRootController alloc] init];
                rootController.leftBarButtonItemType = leftBarButtonItemTypeNone;
                rootController.showDate = model.time;
                [self.navigationController pushViewController:rootController animated:YES];
            }
                break;
            case 1:
            {
                XMTravelassistantNoteController *noteController = [[XMTravelassistantNoteController alloc] init];
                noteController.noteType = cityStartPointType;
                [self.navigationController pushViewController:noteController animated:YES];
            }
                break;
            case 2:
            {
                XMTravelassistantTouristController *touristController = [[XMTravelassistantTouristController alloc] init];
                touristController.date = self.startPointView.titleView.dateLabel.text;
                touristController.cityType = cityStartPointType;
                [self.navigationController pushViewController:touristController animated:YES];
            }
                break;
            case 3:
            {
                XMTravelassistantHotelController *hotelController = [[XMTravelassistantHotelController alloc] init];
                hotelController.date = self.startPointView.titleView.dateLabel.text;
                hotelController.cityType = cityStartPointType;
                [self.navigationController pushViewController:hotelController animated:YES];
                
            }
                break;
            case 4:
                NSLog(@"4");
                break;
        }
    } else {
        XMTravelassistantModel *model = self.travelassistantArray[1];
        switch (clickViewId) {
            case 0: {
                XMAccountRootController *rootController = [[XMAccountRootController alloc] init];
                rootController.leftBarButtonItemType = leftBarButtonItemTypeNone;
                rootController.showDate = model.time;
                [self.navigationController pushViewController:rootController animated:YES];
            }
                break;
                
            case 1:
            {
                XMTravelassistantNoteController *noteController = [[XMTravelassistantNoteController alloc] init];
                noteController.noteType = cityEndPointType;
                [self.navigationController pushViewController:noteController animated:YES];
            }
                break;
            case 2:
            {
                XMTravelassistantTouristController *touristController = [[XMTravelassistantTouristController alloc] init];
                touristController.date = self.startPointView.titleView.dateLabel.text;
                touristController.cityType = cityEndPointType;
                [self.navigationController pushViewController:touristController animated:YES];
            }
                break;
            case 3:
            {
                XMTravelassistantHotelController *hotelController = [[XMTravelassistantHotelController alloc] init];
                hotelController.date = self.startPointView.titleView.dateLabel.text;
                hotelController.cityType = cityEndPointType;
                [self.navigationController pushViewController:hotelController animated:YES];
                
            }
                break;
            case 4:
                break;
        }
    }
}

@end
