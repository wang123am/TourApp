//
//  UIView+AB.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/4.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "UIView+XM.h"

@implementation UIView (XM)
- (void)OnViewClickListener:(id)taget action:(SEL)sel
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:taget action:sel];
    [self addGestureRecognizer:recognizer];
    self.userInteractionEnabled = YES;
}
@end
