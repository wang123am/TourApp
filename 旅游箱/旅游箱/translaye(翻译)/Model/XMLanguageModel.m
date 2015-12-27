//
//  XMLanguageModel.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMLanguageModel.h"

@implementation XMLanguageModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.languageName = dict[@"languageName"];
        self.icon = dict[@"icon"];
        self.langCode = dict[@"langCode"];
        self.baiduLangCode = dict[@"baiduLangCode"];
        self.country = dict[@"country"];
    }
    return self;
}
+(instancetype) modelWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}
@end
