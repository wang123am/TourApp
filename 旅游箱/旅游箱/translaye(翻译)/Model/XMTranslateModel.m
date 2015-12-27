//
//  XMTranslateModel.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/21.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTranslateModel.h"

@implementation XMTranslateModel

-(instancetype) initWithDict:(NSMutableDictionary *)dict
{
    if (self = [super init]) {
        self.from = dict[@"from"];
        self.to = dict[@"to"];
        NSArray *array = dict[@"trans_result"];
        if (array.count){
            NSDictionary *dataDict = array[0];
            self.src = dataDict[@"src"];
            self.dst = dataDict[@"dst"];
        }
        
    }
    return self;
}
+(instancetype) modelWithDict:(NSMutableDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
