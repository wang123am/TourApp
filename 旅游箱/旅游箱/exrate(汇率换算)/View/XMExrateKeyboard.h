//
//  XMExrateKeyboard.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/24.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XMExrateKeyboardDelegate <NSObject>

@optional
-(void)keyboardButtonClick:(NSString *)buttonText;
@end

@interface XMExrateKeyboard : UIView
/** 存储键盘按钮*/
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,strong) NSMutableArray *otherButtonArray;
@property (nonatomic,weak) id <XMExrateKeyboardDelegate> delegate;
@end
