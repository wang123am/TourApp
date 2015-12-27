//
//  XMAppStart.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/4.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//  应用开启时的工具类，初始化一些只运行一次的数据

#import <Foundation/Foundation.h>

@interface XMAppStart : NSObject
/**
 *  根据json数据解析,并存到数据库
 */
+(instancetype) appStart;
@end
