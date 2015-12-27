//
//  XMSettingListModel.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSettingListModel.h"

@implementation XMSettingListModel
-(instancetype) initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.text = dict[@"text"];
        self.icon = dict[@"icon"];
    }
    return self;
}
+(instancetype) modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
