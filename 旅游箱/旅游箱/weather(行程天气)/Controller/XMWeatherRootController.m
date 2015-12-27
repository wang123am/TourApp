//
//  XMWeatherRootController.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/12.
//  Copyright (c) 2015年 xiaoming All rights reserved.
//

#import "XMWeatherRootController.h"
#import "XMMainDb.h"
#import "UIBarButtonItem+XM.h"
#import "XMSetupCity.h"
#import "XMSetTravelRootController.h"
#import "MBProgressHUD+MJ.h"
#import "XMWeatherAccount.h"
#import "XMWeatherCityModel.h"
#import "XMWeatherItem.h"
#import "AFNetworking.h"
#import "XMWeatherItemDetails.h"

#define viewWidth self.view.frame.size.width
#define viewHeight self.view.frame.size.height

@interface XMWeatherRootController ()<XMSetupCityDelegate,XMWeatherItemDeleagate,XMSetTravelRootDelegate>
/**
 *  提醒用户设置城市界面
 */
@property (nonatomic,weak) XMSetupCity *setupCity;

/**
 *  内容滚动条
 */
@property (nonatomic,weak) UIScrollView *scrollerContent;

/**
 *  天气条目
 */
@property (nonatomic,weak) XMWeatherItem *weatherItem;
/**
 *  城市情况集合
 */
@property (nonatomic,strong) NSMutableArray *weathArray;

@property (nonatomic,assign)CGFloat maxDetailsItemY;

/**
 *  保存城市天气详情的数组
 */
@property (nonatomic,strong) NSMutableArray *detailsArray;
@end

@implementation XMWeatherRootController

-(NSMutableArray *)weathArray
{
    if (_weathArray == nil) {
        self.weathArray = [NSMutableArray array];
    }
    return _weathArray;
}

-(NSMutableArray *)detailsArray
{
    if (_detailsArray == nil) {
        self.detailsArray = [NSMutableArray array];
    }
    return _detailsArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"行程天气";
    
    [self addScrollerView];
    //1.判断是否设置了城市
    XMMainDb *db = [[XMMainDb alloc] init];
    if ([db isSetupCity]) {
        NSMutableDictionary *cityDict = [db selectCityNameEnWithStartCity];
        //1.设置了城市，获取城市天气
        [self getCityWeather:cityDict[@"startCityNameEn"] endCity:cityDict[@"endCityNameEn"]];
    } else {
        //没有设置城市
        [self setupCityView];
    }
}
#pragma mark - 设置界面

/**
 *  1.提示用户设置城市
 */
-(void)setupCityView
{
    XMSetupCity *setupCity = [[XMSetupCity alloc] initWithFrame:self.view.frame];
    setupCity.delegate = self;
    self.setupCity = setupCity;
    [self.view addSubview:setupCity];
}

/**
 *  2.获取城市天气情况
 */
-(void)getCityWeather:(NSString *)startCity endCity:(NSString *)endCity
{
    [MBProgressHUD showMessage:@"正在搜查城市天气"];

    //获取起点天气情况
    XMWeatherAccount *startAccount = [XMWeatherAccount accountWithWeaid:endCity];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //获取开始城市的天气情况
    [manager GET:startAccount.weatherUrl parameters:[startAccount accountDict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"result"];
        //转化为模型数据
        for (NSDictionary *dict in array) {
            XMWeatherCityModel *model = [XMWeatherCityModel cityWithDict:dict];
            [self.weathArray addObject:model];
        }
        [self showWheatherView];
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"查询城市天气失败"];
    }];
}

-(void)addScrollerView
{
    UIScrollView *scrollerContent = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollerContent = scrollerContent;
    self.scrollerContent.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollerContent];
}

/**
 *  创建view显示数据
 */
-(void)showWheatherView
{
 
    if (self.weathArray.count == 0) {
        return;
    }
    //显示当天详情
    XMWeatherItem *item = [[XMWeatherItem alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 130)];
    self.weatherItem = item;
    item.delegate = self;
    item.backgroundColor = [UIColor whiteColor];
    item.model = self.weathArray[0];
    [self.scrollerContent addSubview:item];
    
    //显示未来7天天气详情
    CGFloat detailsItemH = 80;
    CGFloat marginTop = 1;
    for (int i = 0; i < self.weathArray.count; i++) {
        XMWeatherItemDetails *detailsItem = [XMWeatherItemDetails detailsWithCityModle:self.weathArray[i]];
        detailsItem.alpha = 0;
        CGFloat detailsItemY = i * (detailsItemH+marginTop) + 130+marginTop;
        detailsItem.frame = CGRectMake(0,detailsItemY,viewWidth,detailsItemH);
        self.maxDetailsItemY = CGRectGetMaxY(detailsItem.frame);
        [self.scrollerContent addSubview:detailsItem];
        [self.detailsArray addObject:detailsItem];
    }
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

-(void)setTravelCallBack:(NSString *)startPoint startDate:(NSString *)startDate endPoint:(NSString *)endPoint endFromDate:(NSString *)fromDate endToDate:(NSString *)toDate
{
    self.setupCity.hidden = YES;
    [self getCityWeather:startPoint endCity:endPoint];
}
/**
 *  点击天气条目
 */
-(void)onWeatherItemClick
{
    [UIView animateWithDuration:0.5 animations:^{
        for (XMWeatherItemDetails *details in self.detailsArray){
            if (details.alpha == 0) {
                details.alpha = 1;
                self.weatherItem.arrowView.image = [UIImage imageNamed:@"weather_page_down_icon_arrow"];
                self.scrollerContent.contentSize = CGSizeMake(0, self.maxDetailsItemY);
            } else {
                self.weatherItem.arrowView.image = [UIImage imageNamed:@"weather_page_up_icon_arrow"];
                details.alpha = 0;
                self.scrollerContent.contentSize = CGSizeZero;
            }
        }
    }];
}
@end
