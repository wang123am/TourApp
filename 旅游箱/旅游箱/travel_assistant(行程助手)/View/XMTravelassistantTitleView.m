//
//  XMTravelassistantTitleView.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantTitleView.h"

@interface XMTravelassistantTitleView ()
/** 天数标签*/
@property (nonatomic,weak) UILabel *dayLabel;
/** 顶部背景*/
@property (nonatomic,weak) UIImageView *topView;
/** 中间View*/
@property (nonatomic,weak) UIView *centerView;
@end

@implementation XMTravelassistantTitleView
-(instancetype) initWithTitle:(NSString *)title dayNumber:(NSString *)dayNumber
{
    if (self = [super init]) {
        UIImageView *topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_color_line_no_shaow"]];
        self.topView = topView;
        [self addSubview:topView];
        
        UIView *centerView = [[UIView alloc] init];
        centerView.backgroundColor = [UIColor whiteColor];
        self.centerView = centerView;
        [self addSubview:centerView];
        
        //添加天数
        UILabel *dayLabel = [[UILabel alloc] init];
        self.dayLabel = dayLabel;
        dayLabel.text = dayNumber;
        dayLabel.textColor = [UIColor blackColor];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.font = [UIFont systemFontOfSize:13];
        [centerView addSubview:dayLabel];
        //添加日期
        UILabel *dateLabel = [[UILabel alloc] init];
        self.dateLabel = dateLabel;
        dateLabel.text = title;
        dateLabel.textColor = [UIColor grayColor];
        dateLabel.font = [UIFont systemFontOfSize:13];
        [centerView addSubview:dateLabel];
    }
    return self;
}

+(instancetype) viewWithTitle:(NSString *)title dayNumber:(NSString *)dayNumber
{
    return [[self alloc] initWithTitle:title dayNumber:dayNumber];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewHeight = self.frame.size.height;
    CGFloat topViewH = 5;
    self.topView.frame = CGRectMake(0, 0, self.frame.size.width, topViewH);
    self.centerView.frame = CGRectMake(0, topViewH, self.frame.size.width, viewHeight - topViewH);
    self.dayLabel.frame = CGRectMake(10, 0, viewHeight - topViewH, viewHeight - topViewH);
    self.dateLabel.frame = CGRectMake(CGRectGetMaxX(self.dayLabel.frame) + 10, 0, 100, viewHeight - topViewH);
}
@end
