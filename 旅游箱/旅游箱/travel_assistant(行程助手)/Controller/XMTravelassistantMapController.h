//
//  XMTravelassistantMapController.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMTravelassistantMapDelegate <NSObject>

@optional
-(void) travelassistantMapSelectCity:(NSString *)city;
@end

@interface XMTravelassistantMapController : UIViewController
@property (nonatomic,weak) id <XMTravelassistantMapDelegate> delegate;
@end
