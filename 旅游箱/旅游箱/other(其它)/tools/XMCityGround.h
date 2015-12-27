//
//  XMCityGround.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/4.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLeaves.h"

@interface XMCityGround : NSObject
/**
 *  城市开头字母
 */
@property (nonatomic,copy) NSString *name;

/**
 *  字母开头的城市集合
 */
@property (nonatomic,strong) NSMutableArray *leaves;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) groundWithDict:(NSDictionary *)dict;
@end
