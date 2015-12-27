//
//  XMStartTourButton.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSetTourButton.h"
@interface XMSetTourButton ()

@end

@implementation XMSetTourButton

- (instancetype) initWithTitle:(NSString *)buttonTitle normalImg:(UIImage *)normalImg presseed:(UIImage *)clickImg isEnableImg:(BOOL)isEnableImg
{
    if (self = [super init]) {
        
        self.enabled = NO;
        [self setBackgroundImage:normalImg forState:UIControlStateNormal];
        if (isEnableImg) {
            [self setBackgroundImage:[UIImage imageNamed:@"travel_page_start_travel_enabled"] forState:UIControlStateDisabled];
        }
        [self setBackgroundImage:clickImg forState:UIControlStateHighlighted];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitle:buttonTitle forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

+ (instancetype) buttonWithTitle:(NSString *)buttonTitle normalImg:(UIImage *)normalImg presseed:(UIImage *)clickImg isEnableImg:(BOOL)isEnableImg
{
    return [[self alloc ] initWithTitle:buttonTitle normalImg:(UIImage *)normalImg presseed:(UIImage *)clickImg isEnableImg:(BOOL)isEnableImg];
}

@end
