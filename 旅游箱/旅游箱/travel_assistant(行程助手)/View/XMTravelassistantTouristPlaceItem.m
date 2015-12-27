//
//  XMTravelassistantTouristPlaceItem.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/9.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantTouristPlaceItem.h"
#import "UIImage+XM.h"

@implementation XMTravelassistantTouristPlaceItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGFloat itemHeight = self.frame.size.height;
        CGFloat imageW = 11;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locate_red_img"]];
        imageView.frame = CGRectMake(0, 0, imageW, itemHeight);
        imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
        
        CGFloat labelW = 40;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), 0, labelW, itemHeight)];
        label.text = @"自动获取";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:9];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
    }
    return self;
}

@end
