//
//  XMSettingHeaderView.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSettingHeaderView.h"

@interface XMSettingHeaderView()
@property (nonatomic,weak) UILabel *titleLabel;
@end

@implementation XMSettingHeaderView
-(instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.alpha = 0.7;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = title;
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
    }
    return  self;
}

+(instancetype) headerViewWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    CGFloat titleLabelY = self.frame.size.height * 0.5;
    self.titleLabel.frame = CGRectMake(margin, titleLabelY, 150, titleLabelY);
}
@end
