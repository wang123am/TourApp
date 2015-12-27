//
//  XMSettingModel.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMSettingModel : NSObject
/** 组的大标题*/
@property (nonatomic,copy) NSString * title;
/** 一组有多小个条目*/
@property (nonatomic,strong) NSMutableArray *list;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) modelWithDict:(NSDictionary *)dict;
@end
