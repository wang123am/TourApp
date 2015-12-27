//
//  XMSettingModel.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSettingModel.h"
#import "XMSettingListModel.h"

@implementation XMSettingModel
-(NSArray *)list
{
    if (!_list) _list = [NSMutableArray array];
    return _list;
}

-(instancetype) initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        NSArray *array = dict[@"list"];
        for (NSDictionary *dict in array) {
            XMSettingListModel *listModel = [XMSettingListModel modelWithDict:dict];
            [self.list addObject:listModel];
        }
    }
    return self;
}
+(instancetype) modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
