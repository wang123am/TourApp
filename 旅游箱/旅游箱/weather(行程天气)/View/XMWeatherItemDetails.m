//
//  XMWeatherItemDetails.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/18.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMWeatherItemDetails.h"

#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height
@interface XMWeatherItemDetails()
/**
 *  日期
 */
@property (nonatomic,weak) UILabel *date;

/**
 *  天气图片
 */
@property (nonatomic,weak) UIImageView *weatherView;

/**
 *  温度
 */
@property (nonatomic,weak) UILabel *temperatureLabel;

@end

@implementation XMWeatherItemDetails

-(instancetype) initWithCityModel:(XMWeatherCityModel*)model
{
    if (self = [super init]) {
        self.backgroundColor =[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
        [self createView];
        [self setupData:model];
    }
    return  self;
}

/**
 *  创建view 控件
 */
-(void) createView
{
    UILabel *date = [[UILabel alloc] init];
    date.textAlignment = NSTextAlignmentCenter;
    date.textColor = [UIColor grayColor];
    date.font = [UIFont systemFontOfSize:15];
    self.date = date;
    [self addSubview:date];
    
    UIImageView *weatherView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_page_night_icon_0"]];
    self.weatherView = weatherView;
    [self addSubview:weatherView];
    
    UILabel *temperatureLabel = [[UILabel alloc] init];
    temperatureLabel.textAlignment = NSTextAlignmentCenter;
    temperatureLabel.font = [UIFont systemFontOfSize:15];
    temperatureLabel.textColor = [UIColor grayColor];
    self.temperatureLabel = temperatureLabel;
    [self addSubview:temperatureLabel];
    
}

/**
 *  设置数据
 */
-(void) setupData:(XMWeatherCityModel *)model
{
    NSString *dateStr = [NSString stringWithFormat:@"%@(%@)",model.days,model.week];
    self.date.text = dateStr;
    
    NSString *imgStr = [NSString stringWithFormat:@"weather_page_night_icon_%@",model.weatid];
    self.weatherView.image = [UIImage imageNamed:imgStr];
    
    self.temperatureLabel.text = model.temperature;
   
//    self.date.text = @"14号";
//    
//    self.weatherView.image = [UIImage imageNamed:@"weather_page_night_icon_1"];
//    self.temperatureLabel.text = @"多云";
}

+(instancetype) detailsWithCityModle:(XMWeatherCityModel*)model
{
    return [[self alloc] initWithCityModel:model];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.date.frame = CGRectMake(0, 0, viewWidth * 0.4, viewHeight);
    
    CGFloat weatherViewSize = 70;
    CGFloat marginLeft = 20;
    self.weatherView.frame = CGRectMake(viewWidth * 0.4 + marginLeft, 0, weatherViewSize, weatherViewSize);
    
    CGFloat labelW = viewWidth - CGRectGetMaxX(self.weatherView.frame);
    CGFloat labelX = CGRectGetMaxX(self.weatherView.frame);
    self.temperatureLabel.frame = CGRectMake(labelX, 0, labelW, viewHeight);

}
@end
