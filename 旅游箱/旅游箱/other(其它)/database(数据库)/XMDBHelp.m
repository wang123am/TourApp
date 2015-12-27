//
//  XMDBHelp.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/5.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMDBHelp.h"

@interface XMDBHelp()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,assign,getter = isOk)BOOL ok;
@property (nonatomic,strong) FMResultSet *resultSet;
@end

@implementation XMDBHelp
-(instancetype)init
{
    if(self = [super init])
    {
        //获取沙盒中数据库名称
        NSString *dataBaseFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"tour.sqlite"];
        NSLog(@"数据库地址：%@",dataBaseFile);
        //创建或打开数据库
        self.queue = [FMDatabaseQueue databaseQueueWithPath:dataBaseFile];
    }
    return self;
}

+(instancetype)help
{
    return [[self alloc] init];
}

-(BOOL) executeSQL:(NSString *)sql
{
    if (sql) {
        [self.queue inDatabase:^(FMDatabase *db) {
            self.ok = [db executeUpdate:sql];
        }];
        NSLog(@"sql是否执行成功:%d",self.ok);
    }
    return self.ok;
}

- (FMResultSet*) query:(NSString*)sql
{
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        self.resultSet = [db executeQuery:sql];
    }];
    NSLog(@"sql是否执行成功:%d",self.ok);
    return self.resultSet;
}
@end
