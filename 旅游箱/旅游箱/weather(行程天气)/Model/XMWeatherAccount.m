//
//  XMWeatherAccount.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/15.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMWeatherAccount.h"

@implementation XMWeatherAccount
- (instancetype)initWithWeaid:(NSString*)weaid
{
    self = [super init];
    if (self) {
        self.weatherUrl = @"http://api.k780.com:88/?app=weather.future";
        self.weaid = weaid;
        self.appkey = @"13321";
        self.sign = @"0276290f3e8ecd50672e7da746b17748";
        self.format = @"json";
    }
    return self;
}

+(instancetype) accountWithWeaid:(NSString *)weaid
{
    return [[self alloc] initWithWeaid:weaid];
}

-(NSMutableDictionary *)accountDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"weaid"] = self.weaid;
    dict[@"appkey"] = self.appkey;
    dict[@"sign"] = self.sign;
    dict[@"format"] = self.format;
    return dict;
}
@end
