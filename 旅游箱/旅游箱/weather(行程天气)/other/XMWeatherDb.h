//
//  XMWeatherDb.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/18.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMWeatherCityModel.h"
@interface XMWeatherDb : NSObject
-(void)saveCityWeatherWithCityModel:(XMWeatherCityModel *)model;
@end
