//
//  UIBarButtonItem+XM.h
//  XiaoMingWeibo
//
//  Created by 梁亦明 on 15/2/8.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XM)
+(UIBarButtonItem *) barButtonItemWithImage:(UIImage *)image selectorImg:(UIImage*)slectorImg target:(id)target action:(SEL)sel;
@end
