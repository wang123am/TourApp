//
//  XMTopScroller.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/11.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTopScroller.h"
#import "XMTimer.h"

@implementation XMTopScroller

-(instancetype) initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        //获取日期
        NSMutableDictionary *nowTime = [XMTimer nowTime];
        self.nowTime = nowTime;
        //添加左边时钟
        CGFloat leftClockCenterX = 80;
        CGFloat clockSize = 150;
        CGFloat clockY = frame.size.height * 0.4;
        
        DDClockView *leftClock = [[DDClockView alloc] initWithFrame:CGRectMake(0, 0, clockSize, clockSize)];
        leftClock.tag = 1;
        leftClock.delegate = self;
        self.leftClock = leftClock;
        leftClock.center = CGPointMake(leftClockCenterX, clockY);
        [self addSubview:leftClock];
        
        //添加中间图片
        UIImageView *centerAir = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_page_divide_between_clocks"]];
        CGFloat centerAirX = 60;
        centerAir.frame = CGRectMake(0, 0, centerAirX, 20);
        centerAir.center = CGPointMake(frame.size.width * 0.5,clockY);
        [self addSubview:centerAir];
        //添加右边时钟
        DDClockView *rightClock = [[DDClockView alloc] initWithFrame:CGRectMake(0, 0, clockSize, clockSize)];
        rightClock.tag = 2;
        rightClock.delegate = self;
        self.rightClock = rightClock;
        CGFloat rightClockCenterX = leftClockCenterX + clockSize + centerAirX;
        rightClock.center = CGPointMake(rightClockCenterX, clockY);
        [self addSubview:rightClock];
        
        //添加城市1
        CGFloat cityHeight = 30;
        CGFloat cityY = 270;
        UILabel *leftCity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.5, cityHeight)];
        self.leftCity = leftCity;
        leftCity.center = CGPointMake(leftClockCenterX, cityY);
        leftCity.textAlignment = NSTextAlignmentCenter;
        leftCity.font = [UIFont boldSystemFontOfSize:20];
        leftCity.textColor = [UIColor darkGrayColor];
        [self addSubview:leftCity];
        
        //添加城市2
        UILabel *rightCity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width *0.5, cityHeight)];
        self.rightCity = rightCity;
        rightCity.center = CGPointMake(rightClockCenterX, cityY);
        rightCity.textAlignment = NSTextAlignmentCenter;
        rightCity.font = [UIFont boldSystemFontOfSize:20];
        rightCity.textColor = [UIColor darkGrayColor];
        [self addSubview:rightCity];
        
        //添加日期1
        CGFloat cityDateHeight = 30;
        CGFloat cityDateY = 300;
        UILabel *cityLeftDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.5, cityDateHeight)];
        self.leftDate = cityLeftDate;
        cityLeftDate.center = CGPointMake(leftClockCenterX, cityDateY);
        cityLeftDate.textAlignment = NSTextAlignmentCenter;
        cityLeftDate.font = [UIFont systemFontOfSize:16];
        cityLeftDate.textColor = [UIColor grayColor];
        [self addSubview:cityLeftDate];
        
        //添加日期2
        UILabel *cityRightDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.5, cityDateHeight)];
        self.rightDate = cityRightDate;
        cityRightDate.center = CGPointMake(rightClockCenterX, cityDateY);
        cityRightDate.textAlignment = NSTextAlignmentCenter;
        cityRightDate.font = [UIFont systemFontOfSize:16];
        cityRightDate.textColor = [UIColor grayColor];
        [self addSubview:cityRightDate];
        
        //添加重新设置按钮
        UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
        resetButton.frame = CGRectMake(0, 0, 120, 30);
        resetButton.center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.9);
        self.resetButton = resetButton;
        [resetButton setTitle:@"重新设置" forState:UIControlStateNormal];
        resetButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [resetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [resetButton setBackgroundImage:[UIImage imageNamed:@"travel_page_reset"] forState:UIControlStateNormal];
        [resetButton setBackgroundImage:[UIImage imageNamed:@"travel_page_reset_pressed"] forState:UIControlStateHighlighted];
        [resetButton addTarget:self action:@selector(resetButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:resetButton];
        //设置scroller滚动范围
        self.contentSize = CGSizeMake(CGRectGetMaxX(rightClock.frame)+11 , 0);
        //隐藏滚动条
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma mark -闹钟跳动代理回调
-(void)clockWithHour:(long)hour minute:(long)minute tag:(long)tag
{
    if (tag == 1) {
        NSString *date = [self setCityDate:hour minute:minute clockJetLag:self.leftClock.clockJetLag];
        self.leftDate.text = date;
    } else if (tag == 2) {
        NSString *date = [self setCityDate:hour minute:minute clockJetLag:self.rightClock.clockJetLag];
        self.rightDate.text = date;
    }
}

-(NSString *)setCityDate:(long)hour minute:(long)minute clockJetLag:(int)clockJetLag
{
    int day = [self.nowTime[@"day"] intValue];
    int chinaHour = [self.nowTime[@"hour"] intValue];
    if (chinaHour - clockJetLag < 0) {
        day--;
        hour = 24 - clockJetLag;
    }
    NSString *str = [NSString stringWithFormat:@"%@月%d日 %ld:%ld",self.nowTime[@"month"],day,hour,minute];
    return str;
}

-(void)resetButtonClick
{
    if ([self.delegate respondsToSelector:@selector(resetButtonClick)]) {
        [self.delegate resetButtonClick];
    }
}
@end
