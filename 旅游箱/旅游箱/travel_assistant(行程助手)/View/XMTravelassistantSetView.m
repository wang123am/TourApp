//
//  XMTravelassistantSetNote.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantSetView.h"
#import "UIImage+XM.h"
#define imgHeight 414
#define setupButtonHeight 40

@interface XMTravelassistantSetView ()
/** 中间图片*/
@property (nonatomic,weak) UIImageView *centerImg;
/** 按钮*/
@property (nonatomic,weak) UIButton *setupButton;
@end

@implementation XMTravelassistantSetView

+(instancetype) setViewWithCenterImg:(UIImage *)centerImage buttonNomalImg:(UIImage *)buttonNom buttonHigImg:(UIImage *)buttonHig
{
    return [[self alloc] initWithCenterImg:centerImage buttonNomalImg:buttonNom buttonHigImg:buttonHig];
}

-(instancetype) initWithCenterImg:(UIImage *)centerImage buttonNomalImg:(UIImage *)buttonNom buttonHigImg:(UIImage *)buttonHig
{
    if (self = [super init]) {
        
        UIImageView *centerImg = [[UIImageView alloc] initWithImage:centerImage];
        self.centerImg = centerImg;
        [self addSubview:centerImg];
        
        UIButton *setupButton = [[UIButton alloc] init];
        [setupButton setImage:buttonNom forState:UIControlStateNormal];
        [setupButton setImage:buttonHig forState:UIControlStateHighlighted];
        [setupButton addTarget:self action:@selector(setupButtonButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.setupButton = setupButton;
        [self addSubview:setupButton];
    }
    return self;
}


/**
 *  点击按钮时调用
 */
-(void)setupButtonButtonClick
{
    if ([self.delegate respondsToSelector:@selector(travelassistantSetViewButtonClick)]) {
        [self.delegate travelassistantSetViewButtonClick];
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.centerImg.frame = (CGRect){CGPointZero,self.centerImg.image.size};
    self.centerImg.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.4);
    self.setupButton.frame = CGRectMake(0, 0, self.frame.size.width * 0.3, setupButtonHeight);
    self.setupButton.center = CGPointMake(self.frame.size.width * 0.5, CGRectGetMaxY(self.centerImg.frame) + setupButtonHeight * 0.5);
}

@end
