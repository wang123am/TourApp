//
//  XMTravelassistantCityView.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTravelassistantCityView : UIView
/** 城市按钮*/
@property (nonatomic,weak) UIButton *cityButton;
-(instancetype) initWithCity:(NSString *)city;
+(instancetype) viewWithCity:(NSString *)city;
@end
