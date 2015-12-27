//
//  XMAccountDb.m
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMAccountDb.h"
#import "FMDB.h"
#import "XMTimer.h"

@interface XMAccountDb()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,assign,getter=isConsume)BOOL consume;
@property (nonatomic,strong) NSMutableArray *accountArray;
/** 货币符号*/
@property (nonatomic,copy) NSString * symbol;
@property (nonatomic,copy) NSString * rate;
@property (nonatomic,strong) NSMutableArray *alldataArray;
@end

@implementation XMAccountDb
-(NSMutableArray *)accountArray
{
    if (_accountArray == nil) _accountArray = [NSMutableArray array];
    return _accountArray;
}
-(NSMutableArray *)alldataArray
{
    if (_alldataArray == nil) _alldataArray = [NSMutableArray array];
    return _alldataArray;
}

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

-(void)insertToAccountWithType:(NSString *)type money:(NSString *)money exrate:(NSString*)exrate code:(NSString*)code date:(NSString*)date comments:(NSString *)comments imgPath:(NSString *)imgPath
{
    
    NSString *sql = @"INSERT INTO accounts (type,money,exrate,code,date,comments,image) VALUES (?,?,?,?,?,?,?)";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,type,money,exrate,code,date,comments,imgPath];
    }];
}

-(BOOL)isConsumefromToday:(NSString *)date
{
    self.consume = NO;
    NSString *sql = @"SELECT * FROM accounts WHERE date = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql,date];
        if (set.next) {
            self.consume = YES;
        }
    }];
    return self.consume;
}

-(NSMutableArray *) selectAccountData:(NSString *)date
{
    self.accountArray = nil;
    NSString *sql = @"SELECT * FROM accounts WHERE date = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql,date];
        while (set.next) {
            XMAccountModel *model = [self createAccountModelWithSet:set];
            [self.accountArray addObject:model];
        }
    }];
    return self.accountArray;
}
-(NSString *)selectMoneySymbolWithCode:(NSString *)code
{
    NSString *sql = @"SELECT symbol FROM exrate where code = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql,code];
        while (set.next) {
            self.symbol = [set stringForColumn:@"symbol"];
        }
    }];
    return self.symbol;
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

-(NSMutableArray *)selectAccountDataFromMonth:(NSString *) month
{
    NSString *sql = @"SELECT * FROM accounts WHERE date like ?";
    NSString *daySql = @"SELECT * FROM accounts WHERE date = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql,month];
        NSMutableSet *daySetArray = [NSMutableSet set];
        while (set.next) {
            //添加不重复的日期到set集合中
            NSString *date = [set stringForColumn:@"date"];
            [daySetArray addObject:date];
        }
        //遍历set集合
        NSMutableArray *dateArray = (NSMutableArray *)[daySetArray allObjects];
        dateArray = (NSMutableArray *)[dateArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            int value1 = [[obj1 substringWithRange:NSMakeRange(8, 2)] intValue];
            int value2 = [[obj2 substringWithRange:NSMakeRange(8, 2)] intValue];
            
            if (value1 > value2) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            if (value1 < value2) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        for (NSString *date in dateArray) {
            NSMutableArray *array = [NSMutableArray array];
            FMResultSet *daySet = [db executeQuery:daySql,date];
            while (daySet.next) {
                XMAccountModel * model = [self createAccountModelWithSet:daySet];
                [array addObject:model];
            }
            [self.alldataArray addObject:array];
        }

    }];
    return self.alldataArray;
}

-(XMAccountModel*)createAccountModelWithSet:(FMResultSet*)set
{
    int modelid = [set intForColumn:@"id"];
    NSString *type = [set stringForColumn:@"type"];
    NSString *money = [set stringForColumn:@"money"];
    NSString *exrate = [set stringForColumn:@"exrate"];
    NSString *code = [set stringForColumn:@"code"];
    NSString *date = [set stringForColumn:@"date"];
    NSString *comments = [set stringForColumn:@"comments"];
    NSString *image = [set stringForColumn:@"image"];
    
    XMAccountModel *model = [[XMAccountModel alloc] init];
    model.modelid = modelid;
    model.type = type;
    model.money = money;
    model.exrate = exrate;
    model.code = code;
    model.date = date;
    model.comments = comments;
    model.image = image;
    
    if (![model.comments isEqualToString:@""]) {
        model.haveComments = YES;
    }
    if (![model.image isEqualToString:@""]) {
        model.havePhoto = YES;
    }
    
    if ([type isEqualToString:@"餐饮"]) {
        model.consumeType = eatType;
    } else if ([type isEqualToString:@"交通"]) {
        model.consumeType = trafficType;
    } else if ([type isEqualToString:@"购物"]) {
        model.consumeType = shoppingType;
    } else if ([type isEqualToString:@"娱乐"]) {
        model.consumeType = amuseType;
    } else if ([type isEqualToString:@"美容"]) {
        model.consumeType = facialType;
    } else if ([type isEqualToString:@"住宿"]) {
        model.consumeType = hotelType;
    } else if ([type isEqualToString:@"门票"]) {
        model.consumeType = ticketType;
    } else if ([type isEqualToString:@"医疗"]) {
        model.consumeType = hospitalType;
    } else if ([type isEqualToString:@"保险"]) {
        model.consumeType = insuranceType;
    } else if ([type isEqualToString:@"其它"]) {
        model.consumeType = otherType;
    }
    return model;
}
-(void) deleteAccountWithid:(int)modelId
{
    NSString *sql = @"DELETE FROM accounts WHERE id = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,[NSString stringWithFormat:@"%d",modelId]];
    }];
}
@end
