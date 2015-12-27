//
//  XMTimer.m
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTimer.h"

@implementation XMTimer
+(BOOL)isToday:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    return [[dateFormatter stringFromDate:date] isEqualToString:[XMTimer toDay]];
}

+(NSString *)toDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *now = [NSDate date];
    NSString *dateNow = [dateFormatter stringFromDate:now];
    return dateNow;
}

+(NSString *)tomorrow
{
    NSDateFormatter *tomorrowTime = [[NSDateFormatter alloc] init];
    [tomorrowTime setDateFormat:@"yyyy/MM/dd"];
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSinceNow:+(24*60*60)];
    NSString *tomorrow = [tomorrowTime stringFromDate:tomorrowDate];
    return tomorrow;
}

+(NSString *)currentTime:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *now = [NSDate date];
    NSString *dateNow = [dateFormatter stringFromDate:now];
    return dateNow;
}

+(NSMutableDictionary*)nowTime
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    long year = [dateComponent year];
    long month = [dateComponent month];
    long day = [dateComponent day];
    long hour = [dateComponent hour];
    long minute = [dateComponent minute];
    long second = [dateComponent second];
    
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionary];
    [dateDict setObject:[[NSNumber numberWithLong:year] stringValue] forKey:@"year"];
    [dateDict setObject:[[NSNumber numberWithLong:month] stringValue] forKey:@"month"];
    [dateDict setObject:[[NSNumber numberWithLong:day] stringValue] forKey:@"day"];
    [dateDict setObject:[[NSNumber numberWithLong:hour] stringValue] forKey:@"hour"];
    [dateDict setObject:[[NSNumber numberWithLong:minute] stringValue] forKey:@"minute"];
    [dateDict setObject:[[NSNumber numberWithLong:second] stringValue] forKey:@"second"];
    return dateDict;
}

+ (NSString*)weekdayString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekdays objectAtIndex:theComponents.weekday];
}
@end
