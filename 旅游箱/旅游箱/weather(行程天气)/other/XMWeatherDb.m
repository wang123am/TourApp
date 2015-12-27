//
//  XMWeatherDb.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/18.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMWeatherDb.h"
#import "FMDB.h"

@interface XMWeatherDb()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@end
@implementation XMWeatherDb
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

-(void)saveCityWeatherWithCityModel:(XMWeatherCityModel *)model
{
    NSString  *selectSql = @"SELECT * FROM cityWeather";
    NSString *upDateSql = @"UPDATE cityWeather SET days = ?,week = ?,citynm = ?,temperature=?,weather=?,wind=?,temp_high=?,temp_low=?,weatid=?";
    NSString *insertSql = @"INSERT INTO cityWeather(days,week,citynm,temperature,weather,wind,temp_high,temp_low,weatid) VALUES (?,?,?,?,?,?,?,?,?)";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *selectSet = [db executeQuery:selectSql];
        if (selectSet.next) {
            //有数据,更改
            [db executeUpdate:upDateSql,model.days,model.week,model.citynm,model.temperature,model.weather,model.wind,model.temp_high,model.temp_low,model.weatid];
        } else {
            //没有数据，创建
            [db executeUpdate:insertSql,model.days,model.week,model.citynm,model.temperature,model.weather,model.wind,model.temp_high,model.temp_low,model.weatid];
        }
    }];
}

@end
