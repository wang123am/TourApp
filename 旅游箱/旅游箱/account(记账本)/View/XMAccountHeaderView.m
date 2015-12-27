//
//  XMAccountHeaderView.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/26.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMAccountHeaderView.h"
#import "UIImage+XM.h"
#import "XMTimer.h"

#define fontSize [UIFont systemFontOfSize:13]
#define labelColor [UIColor colorWithRed:110/255.0 green:180/255.0 blue:220/255.0 alpha:1]
#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height
@interface XMAccountHeaderView()
/** 左边图片*/
@property (nonatomic,weak) UIImageView *leftImg;
/** 右边指示*/
@property (nonatomic,weak) UIImageView *arrowImg;
/** 底部img*/
@property (nonatomic,weak) UIImageView *buttomImg;

@end

@implementation XMAccountHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_page_calendar_icon"] size:CGSizeMake(24, 24)]];
        leftImg.contentMode = UIViewContentModeCenter;
        self.leftImg = leftImg;
        [self addSubview:leftImg];
        
        UILabel *dayLabel = [[UILabel alloc] init];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.text= [XMTimer currentTime:@"MM/dd"];
        dayLabel.textColor = labelColor;
        dayLabel.font = fontSize;
        self.dayLabel = dayLabel;
        [self addSubview:dayLabel];
        
        UILabel *weekLabel = [[UILabel alloc] init];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.text = [XMTimer weekdayString:[XMTimer toDay]];
        weekLabel.textColor = labelColor;
        weekLabel.font = fontSize;
        self.weekLabel = weekLabel;
        [self addSubview:weekLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc] initWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_page_calendar_arrow_icon"] size:CGSizeMake(15, 15)]];
        arrowImg.contentMode = UIViewContentModeLeft;
        self.arrowImg = arrowImg;
        [self addSubview:arrowImg];
        
        UIImageView *buttomImg = [[UIImageView alloc] initWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_page_color_line_no_shaow"] size:CGSizeMake(viewWidth, 5)]];
        self.buttomImg = buttomImg;
        [self addSubview:buttomImg];
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.text = @"¥ 0";
        moneyLabel.alpha = 0.7;
        moneyLabel.textColor = [UIColor redColor];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        self.moneyLabel = moneyLabel;
        [self addSubview:moneyLabel];
    }
    return  self;
}

-(void)setDate:(NSString *)date
{
    NSString *dateStr = [date substringWithRange:NSMakeRange(5, 5)];
    self.dayLabel.text= dateStr;
    self.weekLabel.text = [XMTimer weekdayString:date];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttomH = 5;
    CGFloat margin = 10;
    CGFloat leftImgW = 40;
    self.leftImg.frame = CGRectMake(margin, 0, leftImgW, viewHeight-buttomH);
    
    CGFloat dayLabelW = 40;
    self.dayLabel.frame = CGRectMake(CGRectGetMaxX(self.leftImg.frame), 0, dayLabelW, viewHeight-buttomH);
    
    self.weekLabel.frame = CGRectMake(CGRectGetMaxX(self.dayLabel.frame), 0, dayLabelW, viewHeight-buttomH);
    
    self.arrowImg.frame = CGRectMake(CGRectGetMaxX(self.weekLabel.frame), 0, dayLabelW, viewHeight-buttomH);
    
    self.buttomImg.frame = CGRectMake(0, viewHeight-buttomH, viewWidth, buttomH);
    
    CGFloat moneyLabelX = CGRectGetMaxX(self.arrowImg.frame);
    self.moneyLabel.frame = CGRectMake(moneyLabelX, 0, viewWidth-moneyLabelX-margin, viewHeight-buttomH);
}

@end
