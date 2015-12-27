//
//  XMTimer.h
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMTimer : NSObject
/** 判断时间是否是今天*/
+(BOOL)isToday:(NSDate*)date;
/** 获取今天日期*/
+(NSString *)toDay;
/** 获取明天日期*/
+(NSString *)tomorrow;
/** 获取现在的时间*/
+(NSMutableDictionary*)nowTime;
/** 根据类型返回对应的日期*/
+(NSString *)currentTime:(NSString*)format;
/** 根据日期获取星期*/
+ (NSString*)weekdayString:(NSString *)dateStr;
@end
