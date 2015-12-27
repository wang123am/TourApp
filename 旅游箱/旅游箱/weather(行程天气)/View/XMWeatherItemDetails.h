//
//  XMWeatherItemDetails.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/18.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMWeatherCityModel.h"
@interface XMWeatherItemDetails : UIView
-(instancetype) initWithCityModel:(XMWeatherCityModel*)model;
+(instancetype) detailsWithCityModle:(XMWeatherCityModel*)model;

@end
