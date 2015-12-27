//
//  XMTravelassistantTouristModel.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/11.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMTravelassistantTouristModel : NSObject
/** 景点名称*/
@property (nonatomic,copy) NSString * tourName;
/** 景点位置*/
@property (nonatomic,copy) NSString * tourLocation;
/** 城市类型(出发点,目的地)*/
@property (nonatomic,copy) NSString * cityType;
/** 金额*/
@property (nonatomic,copy) NSString * tourMoney;
/** 币种*/
@property (nonatomic,copy) NSString * tourExrate;
@end
