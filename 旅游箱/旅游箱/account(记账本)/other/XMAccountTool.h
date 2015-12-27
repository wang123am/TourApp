//
//  XMAccountTool.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMAccountDb;
@interface XMAccountTool : NSObject
+(NSString *)calculateAllConsumeWithModelArray:(NSArray *) array db:(XMAccountDb *)db;
@end
