//
//  XMSelectData.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.

//  自定义选择日期和选择地点的view


#import <UIKit/UIKit.h>

@interface XMSelectData : UIView

/** 类型1 ---2张图片2段文字 */
-(instancetype) initWithLeftImg:(UIImage *)leftImg leftText:(NSString *)leftText rightText:(NSString *)rightText rightImg:(UIImage *)rightImg;

@property (nonatomic,weak) UILabel *rightLabel;
@end
