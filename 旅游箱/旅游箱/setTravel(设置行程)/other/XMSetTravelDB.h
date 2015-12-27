//
//  XMSetTravelDB.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/6.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMSetTravelDB : NSObject
/**
 *  查询境外城市的信息
 */
-(NSMutableArray*) selectOutSideCityData;
/**
 *  查询中国热门城市
 */
-(NSMutableArray*) selectChinaHotCity;
/**
 *  根据字母查询中国的城市
 */
-(NSMutableArray *)selectCityWithletter:(NSString *)letter;
/**
 *  创建设置旅游表
 */
-(void) saveStartTourWithStartPoint:(NSString *)startPoint startDate:(NSString *)startDate endPoint:(NSString*)endPoint endFromDate:(NSString *)fromDate endToDate:(NSString *)toDate;
-(void)upDateTravelassistantWithCity:(NSString *)city time:(NSString *)time cityType:(NSString *)cityType;
@end
