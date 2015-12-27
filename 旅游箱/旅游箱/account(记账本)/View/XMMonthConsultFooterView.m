//
//  XMMonthConsultFooterView.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMMonthConsultFooterView.h"
#import "UIImage+XM.h"
@interface XMMonthConsultFooterView()
/** 合计*/
@property (nonatomic,weak) UILabel *leftLabel;
/** 金钱*/
@property (nonatomic,weak) UILabel *moneyLabel;
@end
@implementation XMMonthConsultFooterView
+(instancetype) footerViewWithMoney:(NSString *)money
{
    return [[self alloc] initWithMoney:money];
}

-(instancetype) initWithMoney:(NSString *)money
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"account_page_set_city_toast"]];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.text = @"合计";
        leftLabel.font = [UIFont systemFontOfSize:15];
        leftLabel.textColor = [UIColor grayColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel = leftLabel;
        [self addSubview:leftLabel];
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.textColor = [UIColor redColor];
        moneyLabel.text = [NSString stringWithFormat:@"¥ %@",money];
        moneyLabel.alpha = 0.7;
        moneyLabel.font = [UIFont systemFontOfSize:15];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        self.moneyLabel = moneyLabel;
        [self addSubview:moneyLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    CGFloat margin = 10;
    self.leftLabel.frame = CGRectMake(0, 0, viewHeight, viewHeight);
    CGFloat moneyLabelX = CGRectGetMaxX(self.leftLabel.frame);
    self.moneyLabel.frame = CGRectMake(moneyLabelX, 0, viewWidth-moneyLabelX-margin, viewHeight);
}
@end
