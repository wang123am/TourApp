//
//  XMSetTravelDB.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/6.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSetTravelDB.h"
#import "FMDB.h"
#import "XMCityGround.h"
@interface XMSetTravelDB()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,assign)BOOL setTravelData;
@end

@implementation XMSetTravelDB
- (instancetype)init
{
    self = [super init];
    if (self) {
        //获取数据库对象
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tour.sqlite"];
        self.queue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    return self;
}

-(NSMutableArray*)selectOutSideCityData
{
    NSMutableArray *array = [NSMutableArray array];
    //查询境外城市的信息
    NSString *outSideCityBeginCharSql = @"SELECT DISTINCT beginChar FROM cityList WHERE countryName != ?";
    NSString *outSideCityGroundSql = @"SELECT cityName,countryName,isHot FROM cityList WHERE beginChar = ? AND countryName != ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:outSideCityBeginCharSql,@"中国"];
        while (set.next) {
            NSString *beginChar = [set stringForColumn:@"beginChar"];
            //获取城市组模型
            XMCityGround *outsideCityGround = [[XMCityGround alloc] init];
            outsideCityGround.name = [set stringForColumn:@"beginChar"];
            //根据字母查询城市
            FMResultSet *groundSet = [db executeQuery:outSideCityGroundSql,beginChar,@"中国"];
            while (groundSet.next) {
                //获取城市模型
                XMLeaves *outsideCityLeaves = [[XMLeaves alloc] initWithDict:[groundSet resultDictionary]];
                [outsideCityGround.leaves addObject:outsideCityLeaves];
            }
            [array addObject:outsideCityGround];
        }
    }];
    [self.queue close];
    return array;
}

-(NSMutableArray *)selectChinaHotCity
{
    NSMutableArray * array = [NSMutableArray array];
    NSString *hotCitySql = @"SELECT cityName FROM cityList WHERE countryName = ? AND isHot = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *resultSet = [db executeQuery:hotCitySql,@"中国",@1];
        while(resultSet.next){
            [array addObject:[resultSet stringForColumn:@"cityName"]];
        }
    }];
    return array;
}

-(NSMutableArray *)selectCityWithletter:(NSString *)letter
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *letterCity = @"SELECT cityName FROM cityList WHERE countryName = ? AND beginChar = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *resultSet = [db executeQuery:letterCity,@"中国",letter];
        while (resultSet.next) {
            [array addObject:[resultSet stringForColumn:@"cityName"]];
        }
    }];
    return array;
}

-(void) saveStartTourWithStartPoint:(NSString *)startPoint startDate:(NSString *)startDate endPoint:(NSString*)endPoint endFromDate:(NSString *)fromDate endToDate:(NSString *)toDate
{
    NSString *insertData = @"INSERT INTO startTour (startPoint,startDate,endPoint,endFromDate,endToDate) VALUES (?,?,?,?,?)";
    NSString *upDateData = @"UPDATE startTour SET startPoint = ?,startDate=?,endPoint = ?,endFromDate=?,endToDate=?";
    NSString *setTraveDataSql = @"SELECT * FROM startTour WHERE startPoint = ? AND startDate = ? AND endPoint = ? AND endFromDate = ? AND endToDate = ?";
    NSString *selectAll = @"SELECT * FROM startTour";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:setTraveDataSql,startPoint,startDate,endPoint,fromDate,toDate];
        if (!set.next) {
            FMResultSet *allSet = [db executeQuery:selectAll];
            if (allSet.next) {
                //不为空
                [db executeUpdate:upDateData,startPoint,startDate,endPoint,fromDate,toDate];
            } else {
                [db executeUpdate:insertData,startPoint,startDate,endPoint,fromDate,toDate];
            }
        }
    }];
}

-(void)upDateTravelassistantWithCity:(NSString *)city time:(NSString *)time cityType:(NSString *)cityType
{
    NSString *sql = @"UPDATE travelassistant SET city = ?,time = ? WHERE cityType = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL flag = [db executeUpdate:sql,city,time,cityType];
        NSLog(@"%d",flag);
    }];
}

@end
