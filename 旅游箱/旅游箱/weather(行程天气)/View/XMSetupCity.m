//
//  XMSetupCity.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/13.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSetupCity.h"
#import "UILabel+XM.h"
#define viewWidth frame.size.width
#define viewHeight frame.size.height

@implementation XMSetupCity
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加图片
        UIImageView *imgbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_page_data_check_bg_cion"]];
        imgbg.frame = CGRectMake(0, 0, 330, 150);
        
        imgbg.center = CGPointMake(viewWidth * 0.5, viewHeight * 0.4);
        [self addSubview:imgbg];
        
        //添加文字
        CGFloat marginTop = 10;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgbg.frame) + marginTop, viewWidth, 30)];
        label1.text = @"您还未设置任何城市";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont systemFontOfSize:13];
        [self addSubview:label1];
        
        //添加现在设置
        CGFloat cityNowHeight = 20;
        CGFloat setCityNowY = CGRectGetMaxY(label1.frame) + marginTop;
        UILabel *setCityNow = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 52, cityNowHeight)];
        [setCityNow OnViewClickListener:self action:@selector(setupcityNowClick)];
        setCityNow.center = CGPointMake(viewWidth * 0.5, setCityNowY);
        setCityNow.text = @"现在设置";
        setCityNow.textColor = [UIColor colorWithRed:226/255.0 green:60/255.0 blue:40/255.0 alpha:1];
        setCityNow.font = [UIFont systemFontOfSize:13];
        [self addSubview:setCityNow];
        
        UIImageView *rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_page_no_data_set_icon"]];
        rightView.frame = CGRectMake(CGRectGetMaxX(setCityNow.frame), setCityNowY-7, 15, 15);
        [self addSubview:rightView];
        
        UIImageView *buttomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_page_no_data_depart_line"]];
        buttomLine.frame = CGRectMake(0, 0, 75, 1);
        buttomLine.center = CGPointMake(viewWidth * 0.5 + 5, CGRectGetMaxY(setCityNow.frame));
        [self addSubview:buttomLine];
    }
    return self;
}
/**
 *  点击现在设置
 */
-(void)setupcityNowClick
{
    if ([self.delegate respondsToSelector:@selector(setupcityNowClick)]) {
        [self.delegate setupcityNowClick];
    }
}
@end
