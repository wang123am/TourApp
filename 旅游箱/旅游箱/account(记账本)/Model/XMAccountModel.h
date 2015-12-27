//
//  XMAccountModel.h
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    eatType = 0,
    trafficType,
    shoppingType,
    amuseType,
    facialType,
    hotelType,
    ticketType,
    hospitalType,
    insuranceType,
    otherType
}XMAccountModelType;
@interface XMAccountModel : NSObject
/** id*/
@property (nonatomic,assign)int modelid;
/** 币种类型*/
@property (nonatomic,copy) NSString * type;
/** 金额*/
@property (nonatomic,copy) NSString * money;
/** 币种英文*/
@property (nonatomic,copy) NSString * exrate;
/** 符号*/
@property (nonatomic,copy) NSString * code;
/** 日期*/
@property (nonatomic,copy) NSString * date;
/** 备注*/
@property (nonatomic,copy) NSString * comments;
/** 图片*/
@property (nonatomic,copy) NSString * image;
@property (nonatomic,assign,getter=isHavePhoto)BOOL havePhoto;
@property (nonatomic,assign,getter=isHageComments)BOOL haveComments;
@property (nonatomic,assign)XMAccountModelType consumeType;
//-(instancetype) initWithDict:(NSDictionary *)dict;
//+(instancetype) modelWithDict:(NSDictionary *)dict;
@end
