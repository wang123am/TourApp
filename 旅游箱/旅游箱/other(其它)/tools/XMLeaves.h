//
//  XMLeaves.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/4.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLeaves : NSObject
/**
 *  城市名
 */
@property (nonatomic,copy) NSString * cityName;

/**
 *  国家名
 */
@property (nonatomic,copy) NSString * countryName;

/**
 *  是否是热门城市
 */
@property (nonatomic,copy)NSString *isHot;
/**
 *  城市时差
 */
@property (nonatomic,copy)NSString *timezoneOffset;

/**
 *  条目是否被选中
 */
@property (nonatomic,assign,getter=isSelect)BOOL select;

/**
 *  城市拼音
 */
@property (nonatomic,copy) NSString *cityNameEn;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) leavesWithDict:(NSDictionary *)dict;
@end
