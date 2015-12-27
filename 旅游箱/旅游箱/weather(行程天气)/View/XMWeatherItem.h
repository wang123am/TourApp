//
//  XMWeatherItem.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/15.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMWeatherCityModel.h"

@protocol XMWeatherItemDeleagate <NSObject>

@optional
-(void)onWeatherItemClick;
@end

@interface XMWeatherItem : UIView
@property (nonatomic,strong) XMWeatherCityModel *model;
@property (nonatomic,weak) id <XMWeatherItemDeleagate> delegate;
/**
 *  箭头
 */
@property (nonatomic,weak) UIImageView *arrowView;
@end
