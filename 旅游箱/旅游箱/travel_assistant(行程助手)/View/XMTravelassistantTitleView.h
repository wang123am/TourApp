//
//  XMTravelassistantTitleView.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTravelassistantTitleView : UIView
/** 日期标签*/
@property (nonatomic,weak) UILabel *dateLabel;
-(instancetype) initWithTitle:(NSString *)title dayNumber:(NSString *)dayNumber;
+(instancetype) viewWithTitle:(NSString *)title dayNumber:(NSString *)dayNumber;
@end
