//
//  XMTravelassistantCityView.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantCityView.h"

@interface XMTravelassistantCityView()
/** 位置图片*/
@property (nonatomic,weak) UIImageView *locationView;
@end

@implementation XMTravelassistantCityView
-(instancetype) initWithCity:(NSString *)city
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *locationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"travelassistant_detail_page_locate"]];
        locationView.contentMode = UIViewContentModeCenter;
        self.locationView = locationView;
        [self addSubview:locationView];
        
        UIButton *cityButton = [[UIButton alloc] init];
        self.cityButton = cityButton;
        cityButton.titleLabel.text = city;
        cityButton.userInteractionEnabled = NO;
        cityButton.titleLabel.font = [UIFont systemFontOfSize:10];
        cityButton.titleLabel.textColor = [UIColor whiteColor];
        [cityButton setTitle:city forState:UIControlStateNormal];
        [cityButton setBackgroundColor:[UIColor colorWithRed:103/255.0 green:185/255.0 blue:159/255.0 alpha:1]];
        [self addSubview:cityButton];
    }
    return self;
}

+(instancetype) viewWithCity:(NSString *)city
{
    return [[self alloc] initWithCity:city];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewHeight = self.frame.size.height;
    self.locationView.frame = CGRectMake(0, 0, viewHeight, viewHeight);
    self.cityButton.frame = CGRectMake(CGRectGetMaxX(self.locationView.frame), 15, 40, 20);
}
@end
