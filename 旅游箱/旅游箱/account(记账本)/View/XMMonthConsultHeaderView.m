//
//  XMMonthConsultHeaderView.m
//  旅游箱
//
//  Created by 梁亦明 on 15/3/31.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMMonthConsultHeaderView.h"
#import "UIImage+XM.h"
#define fontSize [UIFont systemFontOfSize:13]
#define labelColor [UIColor colorWithRed:110/255.0 green:180/255.0 blue:220/255.0 alpha:1]
#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height
@interface XMMonthConsultHeaderView()
/** 中间布局*/
@property (nonatomic,weak) UIView *centerView;
/** 日期*/
@property (nonatomic,weak) UILabel *dateLabel;
/** 星期*/
@property (nonatomic,weak) UILabel *weekLabel;
/** */
@property (nonatomic,weak) UIImageView *buttomView;
@end

@implementation XMMonthConsultHeaderView
+(instancetype) headerViewWithDate:(NSString *)date week:(NSString *)week
{
    return [[self alloc] initWithDate:date week:week];
}

-(instancetype) initWithDate:(NSString *)date week:(NSString *)week
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        
        UIView *centerView = [[UIView alloc] init];
        centerView.backgroundColor = [UIColor whiteColor];
        self.centerView = centerView;
        [self addSubview:centerView];
        
        UILabel *dateLabel = [[UILabel alloc] init];
        self.dateLabel = dateLabel;
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.textColor = labelColor;
        dateLabel.text = date;
        dateLabel.font = fontSize;
        [centerView addSubview:dateLabel];
        
        UILabel *weekLabel = [[UILabel alloc] init];
        self.weekLabel = weekLabel;
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.textColor = labelColor;
        weekLabel.text = week;
        weekLabel.font = fontSize;
        [centerView addSubview:weekLabel];
        
        UIImageView *buttomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_color_line_no_shaow"]];
        self.buttomView = buttomView;
        [centerView addSubview:buttomView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttomHeight = 5;
    CGFloat centerViewY = 10;
    CGFloat centerViewH = 30;
    self.centerView.frame = CGRectMake(0, centerViewY, viewWidth, centerViewH);
    self.dateLabel.frame = CGRectMake(0, 0, 100, centerViewH);
    self.weekLabel.frame = CGRectMake(CGRectGetMaxX(self.dateLabel.frame), 0, 50, centerViewH);
    self.buttomView.frame = CGRectMake(0, CGRectGetMaxY(self.dateLabel.frame), viewWidth, buttomHeight);
}

@end
