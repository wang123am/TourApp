//
//  XMTranslateHeaderView.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMTranslateHeaderViewDelegate <NSObject>

@optional
-(void)selectButtonClick:(UIButton *)button;
-(void)centerButtonClick;
@end

@interface XMTranslateHeaderView : UIView
@property (nonatomic,weak) id <XMTranslateHeaderViewDelegate> delegate;
@property (nonatomic,weak) UIButton *leftButton;
@property (nonatomic,weak) UIButton *centerButton;
@property (nonatomic,weak) UIButton *rightButton;
@end
