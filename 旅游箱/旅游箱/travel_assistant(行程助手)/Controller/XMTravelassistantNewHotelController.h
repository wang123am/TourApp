//
//  XMTravelassistantNewHotelController.h
//  旅游箱
//
//  Created by 梁亦明 on 15/10/28.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMTravelassistantHotelModel;
@protocol XMTravelassistantNewHotelControllerDelegate <NSObject>

@optional
-(void) hotelSetupCallBackWithModel:(XMTravelassistantHotelModel *)model;
@end
@interface XMTravelassistantNewHotelController : UIViewController
@property (nonatomic,weak) id <XMTravelassistantNewHotelControllerDelegate> delegate;
/** 当前日期*/
@property (nonatomic,copy) NSString * date;
/** */
@property (nonatomic,copy) NSString * cityType;
@end
