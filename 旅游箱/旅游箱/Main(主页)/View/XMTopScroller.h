//
//  XMTopScroller.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/11.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDClockView.h"

@protocol XMTopScrollerDelegate <UIScrollViewDelegate>
@optional
-(void)resetButtonClick;
@end

@interface XMTopScroller : UIScrollView <DDClockViewDelegate>
@property (nonatomic,weak) id <XMTopScrollerDelegate> delegate;
@property (nonatomic,weak) DDClockView *leftClock;
@property (nonatomic,weak) DDClockView *rightClock;
@property (nonatomic,weak) UILabel *leftCity;
@property (nonatomic,weak) UILabel *rightCity;
@property (nonatomic,weak) UILabel *leftDate;
@property (nonatomic,weak) UILabel *rightDate;
@property (nonatomic,copy) NSMutableDictionary *nowTime;
@property (nonatomic,weak) UIButton *resetButton;
@end
