//
//  XMAnnotation.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//  自定义大头针模型

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface XMAnnotation : NSObject <MKAnnotation>
/** 经纬度*/
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/** 标题*/
@property (nonatomic, copy) NSString *title;
/** 子标题*/
@property (nonatomic, copy) NSString *subtitle;
/** 图片*/
@property (nonatomic, copy) NSString * icon;
@end
