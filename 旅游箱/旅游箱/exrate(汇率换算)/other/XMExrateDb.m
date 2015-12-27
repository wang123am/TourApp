//
//  XMExrateDb.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/24.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMExrateDb.h"
#import "FMDB.h"
#import "XMExrateModel.h"

@interface XMExrateDb()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableArray *exrateArray;
@property (nonatomic,copy) NSString * rate;
@end
@implementation XMExrateDb

-(NSMutableArray *)exrateArray
{
    if (_exrateArray == nil) {
        _exrateArray = [NSMutableArray array];
    }
    return _exrateArray;
}
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
-(NSMutableArray *)selectAllExrateData
{
    NSString *selectSql = @"SELECT * FROM exrate";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:selectSql];
        while (set.next) {
            XMExrateModel *model = [[XMExrateModel alloc] init];
            model.rate = [set stringForColumn:@"rate"];
            model.coin = [set stringForColumn:@"coin"];
            model.code = [set stringForColumn:@"code"];
            [self.exrateArray addObject:model];
        }
    }];
    
    return self.exrateArray;
}
-(NSString *)selectRateWithCode:(NSString *)code
{
    NSString *selectSql = @"SELECT rate FROM exrate WHERE code = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:selectSql,code];
        while (set.next) {
            self.rate = [set stringForColumn:@"rate"];
        }
    }];
    return  self.rate;
}
@end
