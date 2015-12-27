//
//  XMTravelassistantTouristItem.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/8.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTravelassistantTouristItem : UIView
/** 文本输入框*/
@property (nonatomic,weak) UITextField *textField;
/** 关闭键盘*/
-(void)closeKeyboard;
-(instancetype) initWithTitle:(NSString *) title;
+(instancetype) touristItemWithTitle:(NSString *)title;
@end
