//
//  XMAccountDb.h
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMAccountModel.h"
@interface XMAccountDb : NSObject
/** 添加数据到accounts表*/
-(void)insertToAccountWithType:(NSString *)type money:(NSString *)money exrate:(NSString*)exrate code:(NSString *)code date:(NSString*)date comments:(NSString *)comments imgPath:(NSString *)imgPath;
/** 判断今天是否有消费记录*/
-(BOOL)isConsumefromToday:(NSString *)date;
/** 查询当天全部消费记录*/
-(NSMutableArray *) selectAccountData:(NSString *)date;
/** 根据货币英文查询货币符号*/
-(NSString *)selectMoneySymbolWithCode:(NSString *)code;
/** 根据币种英文获取汇率*/
-(NSString *)selectRateWithCode:(NSString *)code;
/** 查询月的全部记录*/
-(NSMutableArray *)selectAccountDataFromMonth:(NSString *) month;
/** 删除记账记录*/
-(void) deleteAccountWithid:(int)modelId;
@end
