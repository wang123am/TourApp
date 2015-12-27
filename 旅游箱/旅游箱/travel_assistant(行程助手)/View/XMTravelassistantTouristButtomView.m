//
//  XMTravelassistantTouristButtomView.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/12.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantTouristButtomView.h"

@implementation XMTravelassistantTouristButtomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat rowHeight = 50;
        UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plus_gray_img"]];
        leftImg.frame = CGRectMake(0, 0, rowHeight, rowHeight);
        leftImg.contentMode = UIViewContentModeCenter;
        leftImg.center = CGPointMake(self.frame.size.width * 0.5-rowHeight, rowHeight*0.5);
        [self addSubview:leftImg];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImg.frame), 0, 60, rowHeight)];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.font = [UIFont systemFontOfSize:13];
        rightLabel.text = @"添加景点";
        [self addSubview:rightLabel];
    }
    return self;
}

@end
