//
//  UIImage+XM.h
//  XiaoMingWeibo
//
//  Created by 梁亦明 on 15/2/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@interface UIImage (XM)
/**
 *  返回一张根据内容自由拉伸的图片
 */
+(UIImage *) resizeImageWithNamed: (NSString *) name;

+ (UIImage *)resizeImageWithNamed:(NSString *)name withLeft:(CGFloat)left withTop:(CGFloat)top;
/**
 *  创建一个指定大小的image
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
