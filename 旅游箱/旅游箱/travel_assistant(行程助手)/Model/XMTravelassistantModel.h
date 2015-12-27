//
//  XMTravelassistantModel.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/4.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMTravelassistantModel : NSObject
/** 出发地*/
@property (nonatomic,copy) NSString * city;
/** 出发时间*/
@property (nonatomic,copy) NSString * time;
/** 当天消费*/
@property (nonatomic,copy) NSString * money;
/** 笔记*/
@property (nonatomic,assign)int noteCount;
/** 景点数*/
@property (nonatomic,assign)int touristCount;
/** 酒店*/
@property (nonatomic,copy) NSString * hotel;
/** 日记*/
@property (nonatomic,assign) int diary;
/** 城市类型*/
@property (nonatomic,copy) NSString * cityType;
@end
