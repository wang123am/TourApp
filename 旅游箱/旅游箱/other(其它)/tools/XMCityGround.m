//
//  XMCityGround.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/4.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMCityGround.h"
#import "XMLeaves.h"

@implementation XMCityGround
-(NSMutableArray *)leaves
{
    if(_leaves == nil){
        _leaves = [NSMutableArray array];
    }
    return _leaves;
}

-(instancetype) initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.name = dict[@"name"];
        NSArray *array = dict[@"leaves"];
        for (NSDictionary *leavesDict in array){
            XMLeaves *leaves = [XMLeaves leavesWithDict:leavesDict];
            [self.leaves addObject:leaves];
        }
    }
    return self;
}
+(instancetype) groundWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
