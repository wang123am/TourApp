//
//  XMStartTourButton.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMSetTourButton : UIButton
+ (instancetype) buttonWithTitle:(NSString *)buttonTitle normalImg:(UIImage *)normalImg presseed:(UIImage *)clickImg isEnableImg:(BOOL)isEnableImg;
- (instancetype) initWithTitle:(NSString *)buttonTitle normalImg:(UIImage *)normalImg presseed:(UIImage *)clickImg isEnableImg:(BOOL)isEnableImg;
@end
