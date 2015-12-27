//
//  XMTravelassistantItem.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTravelassistantItem : UIView
-(instancetype) initWithIcon:(UIImage *)image title:(NSString *)title detailsTitle:(NSString *)details;
+(instancetype) itemWithIcon:(UIImage *)image title:(NSString *)title detailsTitle:(NSString *)details;
@property (nonatomic,copy) NSString *details;
@end
