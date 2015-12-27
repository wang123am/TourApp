//
//  XMAppStart.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/4.
//  Copyright (c) 2015年 xiaoming. All rights reserved.


//
#import "XMAppStart.h"
#import "XMCityGround.h"
#import "FMDB.h"
#import "XMLanguageModel.h"
#import "XMExrateModel.h"

@interface XMAppStart ()
@property (nonatomic,strong) NSDictionary *cityDict;
@property (nonatomic,copy) NSString * cityPath;
@property (nonatomic,copy) NSString * languagePath;
@property (nonatomic,copy) NSString * exratePath;

/** 用于保存json数据 1.国类城市*/
@property (nonatomic,strong) NSMutableArray *cityArray;
/** 保存翻译中的语种*/
@property (nonatomic,strong) NSMutableArray *languageArray;
/** 保存汇率计算的数据*/
@property (nonatomic,strong) NSMutableArray *exrateArray;
@end

@implementation XMAppStart

-(NSMutableArray *)cityArray
{
    if(_cityArray == nil)
    {
        _cityArray = [NSMutableArray array];
        NSArray *array1 = [self asyJsonWithKey:@"areas" path:self.cityPath];
        NSArray *array2 = [self asyJsonWithKey:@"areas2" path:self.cityPath];
        for(NSDictionary *dict in array1){
            XMCityGround *ground = [XMCityGround groundWithDict:dict];
            [_cityArray addObject:ground];
        }
        for (NSDictionary *dict in array2){
            XMCityGround *ground = [XMCityGround groundWithDict:dict];
            [_cityArray addObject:ground];
        }
    }
    return _cityArray;
}

-(NSMutableArray *)languageArray
{
    if (_languageArray == nil)
    {
        _languageArray = [NSMutableArray array];
        NSArray *array = [self asyJsonWithKey:@"languages" path:self.languagePath];
        for (NSDictionary *dict in array)
        {
            XMLanguageModel *model = [XMLanguageModel modelWithDict:dict];
            [_languageArray addObject:model];
        }
    }
    return _languageArray;
}

-(NSMutableArray *)exrateArray
{
    if (_exrateArray == nil) {
        _exrateArray = [NSMutableArray array];
        NSArray *array = [self asyJsonWithKey:@"exrates" path:self.exratePath];
        NSLog(@"----%ld",array.count);
        for (NSDictionary *dict in array) {
            XMExrateModel *model = [XMExrateModel exrateWithDict:dict];
            [_exrateArray addObject:model];
        }
    }
    return _exrateArray;
}


+(instancetype) appStart
{
    return [[self alloc] init];
}

-(instancetype) init
{
    if(self = [super init])
    {
        //获取沙盒中数据库名称
        NSString *dataBaseFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"tour.sqlite"];
        NSFileManager *fileMannager = [NSFileManager defaultManager];
        
        self.cityPath = [[NSBundle mainBundle] pathForResource:@"citylist.json" ofType:nil];
        self.languagePath = [[NSBundle mainBundle] pathForResource:@"language.json" ofType:nil];
        self.exratePath = [[NSBundle mainBundle] pathForResource:@"exrate.json" ofType:nil];
        
        if (![fileMannager fileExistsAtPath:dataBaseFile]) {
            //把数据保存到数据库
            [self saveDataToDb:dataBaseFile];
        }
    }
    return self;
}

/**
 *  根据键值解析json数据
 */
-(NSArray *)asyJsonWithKey:(NSString *)key path:(NSString *)path
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return dict[key];
}

/**
 *  把数据保存到数据库
 */
-(void) saveDataToDb:(NSString *)dataBaseFile
{
    //创建城市列表表
    NSString *createCityListSql = @"CREATE TABLE IF NOT EXISTS cityList(id INTEGER PRIMARY KEY AUTOINCREMENT,beginChar TEXT,cityName TEXT,countryName TEXT,isHot TEXT,timezoneOffset TEXT,cityNameEn TEXT)";
    NSString *insertBase = @"INSERT INTO cityList (beginChar,cityName,countryName,isHot,timezoneOffset,cityNameEn) VALUES (?,?,?,?,?,?)";
    //创建旅游地点表
    NSString *createTourSql = @"CREATE TABLE IF NOT EXISTS startTour(id INTEGER PRIMARY KEY AUTOINCREMENT,startPoint TEXT,startDate TEXT,endPoint TEXT,endFromDate TEXT,endToDate TEXT)";
    //创建城市天气表
    NSString *createWeatherSql = @"CREATE TABLE IF NOT EXISTS cityWeather(id INTEGER PRIMARY KEY AUTOINCREMENT, days TEXT,week TEXT,citynm TEXT,temperature TEXT,weather TEXT,wind TEXT,temp_high TEXT,weatid TEXT)";
    //创建语言表
    NSString *createLanguageSql = @"CREATE TABLE IF NOT EXISTS language(id INTEGER PRIMARY KEY AUTOINCREMENT,languageName TEXT,icon TEXT,langCode TEXT, baiduLangCode TEXT,country TEXT)";
    NSString *insertLanguageSql =@"INSERT INTO language (languageName,icon,langCode,baiduLangCode,country) VALUES (?,?,?,?,?)";
    //创建翻译表
    NSString *createTranslateSql = @"CREATE TABLE IF NOT EXISTS translate(id INTEGER PRIMARY KEY AUTOINCREMENT,fromCode TEXT,toCode TEXT,src TEXT, dst TEXT)";
    //创建汇率换算表
    NSString *createExrateSql = @"CREATE TABLE IF NOT EXISTS exrate(id INTEGER PRIMARY KEY AUTOINCREMENT,symbol TEXT,rate TEXT,coin TEXT,code TEXT)";
    NSString *insertExrateSql = @"INSERT INTO exrate (symbol,rate,coin,code) VALUES (?,?,?,?)";
    //创建记账表
    NSString *createAccountsSql = @"CREATE TABLE IF NOT EXISTS accounts(id INTEGER PRIMARY KEY AUTOINCREMENT,type TEXT,money TEXT,exrate TEXT,code TEXT,date TEXT,comments TEXT,image TEXT)";
    //创建行程日记表
    NSString *createTravelassistantSql = @"CREATE TABLE IF NOT EXISTS travelassistant(id INTEGER PRIMARY KEY AUTOINCREMENT,city TEXT,time TEXT,money TEXT,noteCount TEXT,touristCount TEXT,hotel TEXT,diary TEXT,cityType TEXT)";
    NSString *insertTravelassistantSql = @"INSERT INTO travelassistant (city,time,money,noteCount,touristCount,hotel,diary,cityType) VALUES (?,?,?,?,?,?,?,?)";
    //创建或打开数据库
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dataBaseFile];
    //异步添加数据
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        //创建表
        [db executeUpdate:createCityListSql];
        [db executeUpdate:createTourSql];
        [db executeUpdate:createWeatherSql];
        [db executeUpdate:createLanguageSql];
        [db executeUpdate:createTranslateSql];
        [db executeUpdate:createExrateSql];
        [db executeUpdate:createAccountsSql];
        [db executeUpdate:createTravelassistantSql];
        dispatch_async(q, ^{
            //添加数据
            for (int i = 0; i < self.cityArray.count; i++) {
                //获取城市组模型
                XMCityGround *city = self.cityArray[i];
                for (int j = 0; j < city.leaves.count; j++) {
                    //获取城市模型
                    XMLeaves *leaves = city.leaves[j];
                    [db executeUpdate:insertBase,city.name,leaves.cityName,leaves.countryName,leaves.isHot,leaves.timezoneOffset,leaves.cityNameEn];
                }
            }
            NSLog(@"----language--%ld",self.languageArray.count);
            for (int i = 0; i < self.languageArray.count; i++) {
                XMLanguageModel *model = self.languageArray[i];
                [db executeUpdate:insertLanguageSql,model.languageName,model.icon,model.langCode,model.baiduLangCode,model.country];
            }
            NSLog(@"----exrate--%ld",self.exrateArray.count);
            for (int i = 0 ; i < self.exrateArray.count; i++) {
                XMExrateModel *model = self.exrateArray[i];
                NSLog(@"----rate---=%@",model.rate);
                [db executeUpdate:insertExrateSql,model.symbol,model.rate,model.coin,model.code];
            }
            NSLog(@"---添加两条假数据到行程助手表");
            [db executeUpdate:insertTravelassistantSql,@"广州",@"2015/02/22",@"¥ 0",@"0",@"0",@"暂未填写",@"0",@"startPoint"];
            [db executeUpdate:insertTravelassistantSql,@"北京",@"2015/03/22",@"¥ 0",@"0",@"0",@"暂未填写",@"0",@"endPoint"];
        });
    }];
}

@end
