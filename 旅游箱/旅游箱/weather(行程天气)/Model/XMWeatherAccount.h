//
//  XMWeatherAccount.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/15.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMWeatherAccount : NSObject
/**
 *  天气url地址
 */
@property (nonatomic,copy) NSString * weatherUrl;
/**
 *  天气appkey
 */
@property (nonatomic,copy) NSString * appkey;
/**
 *  appkey加密
 */
@property (nonatomic,copy) NSString * sign;
/**
 *  返回数据
 */
@property (nonatomic,copy) NSString * format;
/**
 *  城市
 */
@property (nonatomic,copy) NSString * weaid;

- (instancetype)initWithWeaid:(NSString*)weaid;
+(instancetype) accountWithWeaid:(NSString *)weaid;
-(NSMutableDictionary *)accountDict;
@end
