//
//  XMWeatherCityModel.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/15.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMWeatherCityModel.h"

@implementation XMWeatherCityModel

-(instancetype) initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        self.days = dict[@"days"];
        self.week = dict[@"week"];
        self.citynm = dict[@"citynm"];
        self.temperature = dict[@"temperature"];
        self.weather = dict[@"weather"];
        self.wind = dict[@"wind"];
        self.temp_high = dict[@"temp_high"];
        self.temp_low = dict[@"temp_low"];
        self.weatid = dict[@"weatid"];
    }
    return self;
}
+(instancetype) cityWithDict:(NSDictionary *)dict
{
    return [[self alloc ] initWithDict:dict];
}
@end
