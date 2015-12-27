//
//  XMAccountHeaderView.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/26.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMAccountHeaderView : UIView
/** 金钱*/
@property (nonatomic,weak) UILabel  *moneyLabel;
/** 日期*/
@property (nonatomic,weak) UILabel *dayLabel;
/** 星期*/
@property (nonatomic,weak) UILabel *weekLabel;
/** 设置时间*/
@property (nonatomic,copy) NSString *date;
@end
