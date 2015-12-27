//
//  XMDBHelp.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/5.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//      对FMDB数据库进行进一步的封装
#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface XMDBHelp : NSObject
/**
 *  更改数据操作
 */
- (BOOL) executeSQL:(NSString *)sql;
/**
 *  查询数据操作
 */
- (FMResultSet *) query:(NSString *)sql;

+(instancetype) help;
@end
