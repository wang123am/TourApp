//
//  XMTravelassistantDb.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/5.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

#define noteTableName @"note"
#define touristTableName @"tourist"

@class XMTravelassistantNoteModel,XMTravelassistantTouristModel,XMTravelassistantModel,XMTravelassistantHotelModel;
@interface XMTravelassistantDb : NSObject
/** 查询当前旅游日期*/
-(NSDictionary *)selectTourDate;
/** 查询是否设置了城市*/
-(BOOL) isSetupCity;
/** 查询货币汇率*/
-(NSString *)selectRateWithCode:(NSString *)code;
/** 查询当天全部消费记录*/
-(NSMutableArray *) selectAccountData:(NSString *)date;
/** 查询行程助手全部信息*/
-(NSMutableArray *) selectTravelassistantData;
/** 根据城市类型查询行程助手*/
-(NSString *)selectTravelassistantDataWithCityType:(NSString *)cityType colmnName:(NSString *)colmnName;
/** 更新总消费的咧*/
-(void)upDateTravelassistantWithMoney:(NSString *)money cityType:(NSString *)cityType;
/** 更改城市*/
-(void)upDateTravelassistantWithCity:(NSString *)city time:(NSString *)time cityType:(NSString *)cityType;
/** 更新行程助手字段*/
-(void)upDateTravelassistantWithColmnName:(NSString *)colmnName colmnValue:(NSString *)colmnValue cityType:(NSString *)cityType;
/** 判断表是否创建*/
-(BOOL)selectTableWithTableName:(NSString *)tableName;
/** 判断表是否有记录*/
-(BOOL)selectTableDataWithTableName:(NSString *)tableName;

/** 创建笔记表*/
-(void)createNoteTable;
/** 添加数据到笔记表*/
-(void)insertNoteWithModel:(XMTravelassistantNoteModel *)model;
/** 获取笔记表全部数据*/
-(NSMutableArray *)selectNoteAllDataWithCityType:(NSString *) cityType;
/** 删除笔记表的数据*/
-(void)deleteNoteDataWithNoteModel:(XMTravelassistantNoteModel *)model;

/** 创建景点表*/
-(void)createTouristTable;
/** 添加数据到景点表*/
-(void)insertTouristWithModel:(XMTravelassistantTouristModel *)model;
/** 获取景点表的全部数据*/
-(NSMutableArray *)selectTouristAllDataWithCityType:(NSString *)cityType;
/** 删除景点*/
-(void) deleteTouristDataWithTouristModel:(XMTravelassistantTouristModel *)model;

/** 创建酒店表*/
-(void) createHotelTable;
/** 添加数据到酒店表*/
-(void)insertHotelWithModel:(XMTravelassistantHotelModel *)model;
/** 获取酒店数据*/
-(XMTravelassistantHotelModel *)selectHotelWithCityType:(NSString *)cityType;
/** 更改酒店数据*/
-(void) updateHotelWithModel:(XMTravelassistantHotelModel *)model;
/** 删除酒店*/
-(void) deleteHotelWithCityType:(NSString *)cityType;
@end
