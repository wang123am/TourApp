//
//  XMTranslateDb.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMTranslateModel.h"
@interface XMTranslateDb : NSObject
/** 查询全部数据库语言*/
-(NSMutableArray*)selectAllLanguageData;
/** 查询数据库中全部翻译的数据*/
-(NSMutableArray *)selectAllTranslateData;
/** 添加数据到翻译的数据表*/
-(void) insertDataToTranslate:(XMTranslateModel *)model;
/** 根据语种查询百度的编码*/
-(NSString *) selectCodeWithLanguage:(NSString *)language;
/** 根据src删除翻译信息*/
-(void) deleteTranslateDataWithSrc:(NSString *)src;
@end
