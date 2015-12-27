//
//  XMMainDb.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/11.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMMainDb : NSObject
/**
 *  根据城市名查询时差
 */
-(NSString*) selectClockWithCity:(NSString*)cityName;
/**
 *  查询是否设置了城市旅游
 */
-(BOOL) isSetupCity;
/**
 *  查询城市
 */
-(NSMutableDictionary *)selectCity;
/**
 *  删除旅游的信息
 */
-(BOOL) deleteCityData;
/**
 *  根据城市获取城市拼音
 */
-(NSMutableDictionary *)selectCityNameEnWithStartCity;
@end
