//
//  XMLeaves.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/4.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMLeaves.h"

@implementation XMLeaves

-(instancetype) initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.cityName = dict[@"cityName"];
        self.countryName = dict[@"countryName"];
        self.isHot = dict[@"isHot"];
        self.timezoneOffset = dict[@"timezoneOffset"];
        self.cityNameEn = dict[@"cityNameEn"];
    }
    return self;
}

+(instancetype) leavesWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
