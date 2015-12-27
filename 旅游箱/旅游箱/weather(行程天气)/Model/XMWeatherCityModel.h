//
//  XMWeatherCityModel.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/15.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMWeatherCityModel;
@interface XMWeatherCityModel : NSObject
/**
 *  日期
 */
@property (nonatomic,copy) NSString * days;
/**
 *  星期
 */
@property (nonatomic,copy) NSString * week;
/**
 *  城市
 */
@property (nonatomic,copy) NSString * citynm;
/**
 *  温度
 */
@property (nonatomic,copy) NSString * temperature;
/**
 *  天气
 */
@property (nonatomic,copy) NSString * weather;
/**
 *  风向
 */
@property (nonatomic,copy) NSString * wind;
/**
 *  最高温度
 */
@property (nonatomic,copy) NSString * temp_high;
/**
 *  最低温度
 */
@property (nonatomic,copy) NSString * temp_low;
/**
 *  天气id
 */
@property (nonatomic,copy) NSString * weatid;

-(instancetype) initWithDict:(NSDictionary*)dict;
+(instancetype) cityWithDict:(NSDictionary *)dict;

@property (nonatomic,strong) XMWeatherCityModel *model;
@end
