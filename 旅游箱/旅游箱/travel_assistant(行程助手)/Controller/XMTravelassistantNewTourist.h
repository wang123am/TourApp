//
//  XMTravelassistantNewTourist.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMTravelassistantNewTouristDelegate <NSObject>

@optional
-(void)travelassistantNewTouristCallBack;
@end

@interface XMTravelassistantNewTourist : UIViewController
/** 当前日期*/
@property (nonatomic,copy) NSString * date;
/** 城市类型*/
@property (nonatomic,copy) NSString * cityType;

@property (nonatomic,weak) id <XMTravelassistantNewTouristDelegate>delegate;
@end
