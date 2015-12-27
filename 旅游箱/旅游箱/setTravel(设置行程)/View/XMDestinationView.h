//
//  XMDestinationView.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.


//  这是一个设置行程中选择目的地的界面

#import <UIKit/UIKit.h>
#import "XMSelectData.h"
#import "XMDestinationDate.h"
@interface XMDestinationView : UIView
@property (nonatomic,weak) XMSelectData *selectCity;
@property (nonatomic,weak) XMDestinationDate *fromDateView;
@property (nonatomic,weak) XMDestinationDate *toDateView;
@end
