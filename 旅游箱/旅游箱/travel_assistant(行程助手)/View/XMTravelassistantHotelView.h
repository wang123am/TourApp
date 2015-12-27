//
//  XMTravelassistantHotelView.h
//  旅游箱
//
//  Created by 梁亦明 on 15/10/27.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMTravelassistantHotelModel.h"

@protocol XMTravelassistantHotelViewDelegate <NSObject>
@optional
-(void) phoneButtonDidClick:(NSString *)phone;
@end

@interface XMTravelassistantHotelView : UIView
@property (nonatomic,strong) XMTravelassistantHotelModel *model;
@property (nonatomic,weak) id <XMTravelassistantHotelViewDelegate> delegate;
@end
