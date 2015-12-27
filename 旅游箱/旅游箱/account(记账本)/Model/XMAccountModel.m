//
//  XMAccountModel.m
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMAccountModel.h"

@implementation XMAccountModel
-(instancetype) initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype) modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
