//
//  XMExrateKeyboard.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/24.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMExrateKeyboard.h"

#define numberCount 9
#define itemWidth 70
#define itemHeight 40
#define viewHeight self.frame.size.height
#define viewWidth self.frame.size.width

@implementation XMExrateKeyboard
-(NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

-(NSMutableArray *)otherButtonArray{
    if (_otherButtonArray == nil) {
        _otherButtonArray = [NSMutableArray array];
    }
    return _otherButtonArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < numberCount; i++) {
            UIButton *button = [[UIButton alloc] init];
            //设置背景
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            //设置普通状态下按钮
            [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            //高亮状态按钮
            NSString *imgHighStr = [NSString stringWithFormat:@"account_page_calc_%d_down",i+1];
            [button setImage:[UIImage imageNamed:imgHighStr] forState:UIControlStateHighlighted];
            //按钮点击
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArray addObject:button];
            [self addSubview:button];
        }
        
        for (int i =0; i < 3 ; i++){
            UIButton *button = [[UIButton alloc] init];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            if (i == 0 ) {
                [button setTitle:@"C" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"account_page_calc_cancle_down"] forState:UIControlStateHighlighted];
            } else if (i == 1){
                [button setTitle:@"0" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"account_page_calc_0_down"] forState:UIControlStateHighlighted];
            } else {
                [button setImage:[UIImage imageNamed:@"account_page_calc_ok"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"account_page_calc_ok_down"] forState:UIControlStateHighlighted];
            }
            [button setBackgroundColor:[UIColor whiteColor]];
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.otherButtonArray addObject:button];
            [self addSubview:button];
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int col = 4;
    //计算间距
    CGFloat margin = (viewWidth - col*itemWidth)/(col+1);
    //设置frame
    for (int i = 0 ; i < self.buttonArray.count; i++){
        UIButton *button = self.buttonArray[i];
        int col = i / 3;
        int line = i % 3;
        CGFloat buttonX = line * (margin + itemWidth) + margin;
        CGFloat buttonY = col * (margin + itemHeight) + margin;
        button.frame = CGRectMake(buttonX, buttonY, itemWidth, itemHeight);
    }
    
    CGFloat otherButtonX = itemWidth * (col - 1) + margin * col;
    for (int i = 0; i < self.otherButtonArray.count; i++) {
        UIButton *button = self.otherButtonArray[i];
        button.frame = CGRectMake(otherButtonX, i * (margin + itemHeight) +margin, itemWidth, itemHeight);
    }
}

/**
 *  按钮点击回调
 */

-(void)onButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(keyboardButtonClick:)]) {
        [self.delegate keyboardButtonClick:button.titleLabel.text];
    }
}
@end
