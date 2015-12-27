//
//  XMAccountTool.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMAccountTool.h"
#import "XMAccountModel.h"
#import "XMAccountDb.h"
@implementation XMAccountTool
/**
 *  计算今天总消费
 */
+(NSString *)calculateAllConsumeWithModelArray:(NSArray *) array db:(XMAccountDb *)db
{
    //获取人民币汇率
    NSString *cnyRate = [db selectRateWithCode:@"CNY"];
    double resultMoney = 0;
    for (int i = 0; i < array.count; i++) {
        XMAccountModel *model = array[i];
        //获取模型中金额的汇率
        NSString *rate = [db selectRateWithCode:model.exrate];
        //计算金额结果
        double money = [[model money] doubleValue] * [cnyRate doubleValue] / [rate doubleValue];
        resultMoney += money;
    }
    NSString *resultStr = [NSString stringWithFormat:@"%f",resultMoney];
    //截取小数点后两位
    NSRange resultRange = [resultStr rangeOfString:@"."];
    return [resultStr substringToIndex:resultRange.location + 3];
}
@end
