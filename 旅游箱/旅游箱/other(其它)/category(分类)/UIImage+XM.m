//
//  UIImage+XM.m
//  XiaoMingWeibo
//
//  Created by 梁亦明 on 15/2/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "UIImage+XM.h"

@implementation UIImage (XM)
+ (UIImage *)resizeImageWithNamed:(NSString *)name
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height * 0.5]; 
}

+ (UIImage *)resizeImageWithNamed:(NSString *)name withLeft:(CGFloat)left withTop:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height * top];
}
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
