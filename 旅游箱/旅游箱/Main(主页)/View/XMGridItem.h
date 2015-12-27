//
//  XMGridItem.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGridItem : UIView
@property (nonatomic,weak) UIButton *imgItem;
-(instancetype) initWithImage:(UIImage *)img selectImg:(UIImage *)selectImg title:(NSString *)title;
+(instancetype) itemWithImage:(UIImage *)img selectImg:(UIImage *)selectImg title:(NSString *)title;
@end
