//
//  UIBarButtonItem+XM.m
//  XiaoMingWeibo
//
//  Created by 梁亦明 on 15/2/8.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "UIBarButtonItem+XM.h"

@implementation UIBarButtonItem (XM)
/**
 *  根据图片创建导航按钮
 *  @return 自定义导航按钮
 */
+(UIBarButtonItem *) barButtonItemWithImage:(UIImage *)image selectorImg:(UIImage*)selectorImg target:(id)target action:(SEL)sel
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:selectorImg forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
