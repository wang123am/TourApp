//
//  XMTranslateFootView.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMTranslateFootViewDelegate <NSObject>

@optional
-(void)sendButtonClick:(NSString *)content;
@end

@interface XMTranslateFootView : UIView
@property (nonatomic,weak) id <XMTranslateFootViewDelegate>delegate;
@property (nonatomic,weak) UITextField *textField;
@property (nonatomic,weak) UIButton *sendButton;
@end
