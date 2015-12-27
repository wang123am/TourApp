//
//  XMMainDb.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/11.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMMainDb.h"
#import "FMDB.h"
#import "XMSetTravelDB.h"

@interface XMMainDb ()
@property (nonatomic,strong) FMDatabaseQueue *queue;
/**
 *  城市时差
 */
@property (nonatomic,copy)NSString *clock;
/**
 *  是否设置了城市旅游
 */
@property (nonatomic,assign)BOOL isExist;
/**
 *  是否删除了城市旅游
 */
@property (nonatomic,assign,getter=isDeleteCity)BOOL deleteCity;
@end

@implementation XMMainDb
-(instancetype) init
{
    if (self = [super init]) {
        //获取数据库对象
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tour.sqlite"];
        NSLog(@"%@",path);
        self.queue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    return self;
}

-(NSString*) selectClockWithCity:(NSString*)cityName
{
    NSString *sql = @"SELECT timezoneOffset FROM cityList WHERE cityName = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql,cityName];
        while (set.next) {
            self.clock = [set stringForColumn:@"timezoneOffset"];
        }
    }];
    return self.clock;
}

-(BOOL) isSetupCity
{
    NSString *sql = @"SELECT * FROM startTour";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql];
        if (set.next) {
            self.isExist = true;
        }
    }];
    return self.isExist;
}

-(NSMutableDictionary *)selectCity
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *sql = @"SELECT * FROM startTour";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql];
        while (set.next) {
            [dict setObject:[set stringForColumn:@"startPoint"] forKey:@"startPoint"];
            [dict setObject:[set stringForColumn:@"endPoint"] forKey:@"endPoint"];
        }
    }];
    return dict;
}

-(BOOL)deleteCityData
{
    NSString *sql = @"DELETE FROM startTour";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        self.deleteCity = [db executeUpdate:sql];
    }];
    return self.isDeleteCity;
}

-(NSMutableDictionary *)selectCityNameEnWithStartCity
{
    NSMutableDictionary *dict = [self selectCity];
    NSString *sql = @"SELECT cityNameEn FROM cityList WHERE cityName = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet * set1 = [db executeQuery:sql,dict[@"startPoint"]];
        FMResultSet * set2 = [db executeQuery:sql,dict[@"endPoint"]];
        if (set1.next) {
            [dict setObject:[set1 stringForColumn:@"cityNameEn"]forKey:@"startCityNameEn"];
        }
        if (set2.next) {
            [dict setObject:[set2 stringForColumn:@"cityNameEn"] forKey:@"endCityNameEn"];
        }
    }];
    return dict;
}
@end
