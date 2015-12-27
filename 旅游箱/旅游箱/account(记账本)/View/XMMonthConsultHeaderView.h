//
//  XMMonthConsultHeaderView.h
//  旅游箱
//
//  Created by 梁亦明 on 15/3/31.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMMonthConsultHeaderView : UIView
-(instancetype) initWithDate:(NSString *)date week:(NSString *)week;
+(instancetype) headerViewWithDate:(NSString *)date week:(NSString *)week;
@end
