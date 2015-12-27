//
//  XMTranslateHeaderView.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTranslateHeaderView.h"

@implementation XMTranslateHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.tag = 1;
        leftButton.backgroundColor = [UIColor whiteColor];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"citychoice_page_search_pressed"] forState:UIControlStateHighlighted];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftButton setTitle:@"简体中文" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.leftButton = leftButton;
        [self addSubview:leftButton];
        
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerButton setBackgroundImage:[UIImage imageNamed:@"citychoice_page_search_pressed"] forState:UIControlStateHighlighted];
        centerButton.backgroundColor = [UIColor whiteColor];
        [centerButton setImage:[UIImage imageNamed:@"translate_page_swap_lang_img"] forState:UIControlStateNormal];
        self.centerButton = centerButton;
        [centerButton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerButton];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.tag = 2;
        [rightButton setBackgroundImage:[UIImage imageNamed:@"citychoice_page_search_pressed"] forState:UIControlStateHighlighted];
        rightButton.backgroundColor = [UIColor whiteColor];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightButton setTitle:@"英语" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.rightButton = rightButton;
        [rightButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    
    CGFloat centerButtonW = 100;
    CGFloat margin = 1;
    self.centerButton.frame = CGRectMake(0, 0, centerButtonW, viewHeight);
    self.centerButton.center = CGPointMake(viewWidth * 0.5, viewHeight * 0.5);
    
    CGFloat buttonW = (viewWidth - centerButtonW -2*margin)/2;
    self.leftButton.frame = CGRectMake(0, 0, buttonW, viewHeight);
    
    self.rightButton.frame = CGRectMake(CGRectGetMaxX(self.centerButton.frame)+margin, 0, buttonW, viewHeight);
}

-(void)selectButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(selectButtonClick:)]) {
        [self.delegate selectButtonClick:button];
    }
}

-(void)centerButtonClick
{
    if ([self.delegate respondsToSelector:@selector(centerButtonClick)]) {
        [self.delegate centerButtonClick];
    }
}

@end
