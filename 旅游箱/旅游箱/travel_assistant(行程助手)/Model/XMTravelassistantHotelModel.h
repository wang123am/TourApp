//
//  XMTravelassistantHotelModel.h
//  旅游箱
//
//  Created by 梁亦明 on 15/10/27.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMTravelassistantHotelModel : NSObject
/**
 *  图片地址
 */
@property (nonatomic,copy) NSString * imgPath;

/**
 *  酒店名
 */
@property (nonatomic,copy) NSString * hotelName;

/**
 *  酒店电话
 */
@property (nonatomic,copy) NSString * hotelPhone;
/**
 *  酒店位置
 */
@property (nonatomic,copy) NSString * hotelLocation;
/** 金额*/
@property (nonatomic,copy) NSString * tourMoney;
/** 币种*/
@property (nonatomic,copy) NSString * tourExrate;

/** 城市类型*/
@property (nonatomic,copy) NSString * cityType;
@end
