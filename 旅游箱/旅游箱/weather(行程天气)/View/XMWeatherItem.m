//
//  XMWeatherItem.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/15.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMWeatherItem.h"
#import "UIView+XM.h"
@interface XMWeatherItem()
/**
 *  天气图片
 */
@property (nonatomic,weak) UIImageView *weatherView;

/**
 *  天气温度
 */
@property (nonatomic,weak) UILabel *temperatureLabel;

/**
 *  天气
 */
@property (nonatomic,weak) UILabel *weatherLabel;

/**
 *  城市
 */
@property (nonatomic,weak) UILabel *citynmLabel;


@end

@implementation XMWeatherItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *weatherView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_page_icon_9"]];
        self.weatherView = weatherView;
        [self addSubview:weatherView];
        
        UILabel *temperatureLabel = [[UILabel alloc ]init];
        temperatureLabel.font = [UIFont systemFontOfSize:20];
        temperatureLabel.textColor = [UIColor blackColor];
        self.temperatureLabel = temperatureLabel;
        [self addSubview:temperatureLabel];
        
        UILabel *weatherLabel = [[UILabel alloc] init];
        weatherLabel.font = [UIFont systemFontOfSize:13];
        weatherLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:60.0/255.0 blue:40.0/255.0 alpha:1];
        self.weatherLabel = weatherLabel;
        [self addSubview:weatherLabel];
        
        UILabel *citynmLabel = [[UILabel alloc] init];
        citynmLabel.font = [UIFont systemFontOfSize:17];
        citynmLabel.textColor = [UIColor blackColor];
        self.citynmLabel = citynmLabel;
        citynmLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:citynmLabel];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_page_down_icon_arrow"]];
        self.arrowView = arrowView;
        [self addSubview:arrowView];
        
        self.weatherView.image = [UIImage imageNamed:@"weather_page_icon_7"];
        self.temperatureLabel.text = @"17c/20c";
        self.weatherLabel.text = @"多云";
        self.citynmLabel.text = @"广州";
        
        [self OnViewClickListener:self action:@selector(onWeatherItemClick)];
    }
    return self;
}

-(void)setModel:(XMWeatherCityModel *)model
{
    _model = model;
    NSString *viewStr = [NSString stringWithFormat:@"weather_page_icon_%@",model.weatid];
    self.weatherView.image = [UIImage imageNamed:viewStr];
    self.temperatureLabel.text = model.temperature;
    self.weatherLabel.text = model.weather;
    self.citynmLabel.text = model.citynm;
    
//    self.weatherView.image = [UIImage imageNamed:@"weather_page_icon_10"];
//    self.temperatureLabel.text = @"17/20";
//    self.weatherLabel.text = @"多云";
//    self.citynmLabel.text = @"广州";
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 5;
    self.weatherView.frame = CGRectMake(2*margin, margin, 124, 124);
    
    CGFloat temperatureLabelX = CGRectGetMaxX(self.weatherView.frame) + 2*margin;
    self.temperatureLabel.frame = CGRectMake(temperatureLabelX,30, 100, 40);
    
    self.weatherLabel.frame = CGRectMake(temperatureLabelX, CGRectGetMaxY(self.temperatureLabel.frame), 100, 40);
    
    CGFloat citynmLabelW = 120;
    CGFloat citynmLabelX = self.frame.size.width - citynmLabelW - 2*margin;
    self.citynmLabel.frame = CGRectMake(citynmLabelX, self.frame.size.height * 0.5 - 15, citynmLabelW, 30);
    
    self.arrowView.frame = CGRectMake(332, self.frame.size.height * 0.5 + 10, 30, 30);
}

-(void)onWeatherItemClick
{
    if ([self.delegate respondsToSelector:@selector(onWeatherItemClick)]) {
        [self.delegate onWeatherItemClick];
    }
}
@end
