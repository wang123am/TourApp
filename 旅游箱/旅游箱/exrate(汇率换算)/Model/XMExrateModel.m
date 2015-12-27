//
//  XMExrateModel.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/23.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMExrateModel.h"

@implementation XMExrateModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)exrateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
