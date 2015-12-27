//
//  XMTranslateDb.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTranslateDb.h"
#import "FMDB.h"
#import "XMLanguageModel.h"
#import "XMTranslateModel.h"
#import "XMTranslateViewCellFrame.h"

@interface XMTranslateDb()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableArray *languageArray;
@property (nonatomic,strong) NSMutableArray *translateArray;
@property (nonatomic,copy) NSString * baiduCode;
@end
@implementation XMTranslateDb
-(NSMutableArray *)languageArray
{
    if (_languageArray == nil) {
        _languageArray = [NSMutableArray array];
    }
    return _languageArray;
}
-(NSMutableArray *)translateArray
{
    if (_translateArray == nil)
        _translateArray = [NSMutableArray array];
    return _translateArray;
}
-(instancetype) init
{
    if (self = [super init]) {
        //获取数据库对象
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tour.sqlite"];
        self.queue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    return self;
}

-(NSMutableArray*)selectAllLanguageData
{
   
    NSString *selectAllSql = @"SELECT * FROM language";
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:selectAllSql];
        while (set.next) {
            XMLanguageModel *model = [[XMLanguageModel alloc] init];
            model.languageName = [set stringForColumn:@"languageName"];
            model.icon = [set stringForColumn:@"icon"];
            model.langCode = [set stringForColumn:@"langCode"];
            model.baiduLangCode = [set stringForColumn:@"baiduLangCode"];
            model.country = [set stringForColumn:@"country"];
            [self.languageArray addObject:model];
        }
    }];
    return self.languageArray;
}
-(NSMutableArray *)selectAllTranslateData
{
    NSString *sql = @"SELECT * FROM translate";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql];
        while (set.next) {
            XMTranslateViewCellFrame *cellFrame = [[XMTranslateViewCellFrame alloc] init];
            XMTranslateModel *model = [[XMTranslateModel alloc] init];
            model.from = [set stringForColumn:@"fromCode"];
            model.to = [set stringForColumn:@"toCode"];
            model.src = [set stringForColumn:@"src"];
            model.dst = [set stringForColumn:@"dst"];
            cellFrame.model = model;
            [self.translateArray addObject:cellFrame];
        }
    }];
    return self.translateArray;
}

-(void) insertDataToTranslate:(XMTranslateModel *)model
{
    NSString *sql = @"INSERT INTO translate (fromCode,toCode,src,dst) VALUES (?,?,?,?)";
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,model.from,model.to,model.src,model.dst];
    }];
}

-(NSString *) selectCodeWithLanguage:(NSString *)language
{
    NSString *sql = @"SELECT baiduLangCode FROM language WHERE languageName = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *set = [db executeQuery:sql,language];
        while (set.next) {
            self.baiduCode = [set stringForColumn:@"baiduLangCode"];
        }
    }];
    return self.baiduCode;
}

-(void) deleteTranslateDataWithSrc:(NSString *)src
{
    NSString *sql = @"DELETE FROM translate WHERE src = ?";
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql,src];
    }];
}
@end
