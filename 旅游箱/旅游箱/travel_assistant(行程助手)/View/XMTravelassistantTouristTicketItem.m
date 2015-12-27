//
//  XMTravelassistantTouristMoneyItem.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/9.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantTouristTicketItem.h"


@interface XMTravelassistantTouristTicketItem ()
/** 左边label*/
@property (nonatomic,weak) UILabel *leftLabel;
@property (nonatomic,weak) UIImageView *rightAllow;
@end

@implementation XMTravelassistantTouristTicketItem

-(instancetype) initWithTitle:(NSString *)title rightLabelText:(NSString *)rightText
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.backgroundColor = [UIColor whiteColor];
        leftLabel.text = title;
        leftLabel.textColor = [UIColor grayColor];
        leftLabel.font = [UIFont systemFontOfSize:13];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel = leftLabel;
        [self addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.font = [UIFont systemFontOfSize:13];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.text = rightText;
        self.rightLabel = rightLabel;
        [self addSubview:rightLabel];
        
        if ([rightText isEqual:@"CNY"]) {
            UIImageView *rightAllow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_money_choice_arrow"]];
            rightAllow.contentMode = UIViewContentModeCenter;
            self.rightAllow = rightAllow;
            [self addSubview:rightAllow];
        }
    }
    return self;
}
+(instancetype) ticketItemWithTitle:(NSString *)title rightLabelText:(NSString *)rightText
{
    return [[self alloc] initWithTitle:title rightLabelText:(NSString *)rightText];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    self.leftLabel.frame = CGRectMake(0, 0, 50, viewHeight);
    
    CGFloat margin = 10;
    CGFloat rightLabelX = CGRectGetMaxX(self.leftLabel.frame) + 10;
    self.rightLabel.frame = CGRectMake(rightLabelX, 0, viewWidth-rightLabelX - margin, viewHeight);
    
    if (self.itemType) {
        CGFloat rightAllowW = 15;
        self.rightLabel.frame = CGRectMake(rightLabelX, 0, viewWidth-rightLabelX-3*margin, viewHeight);
        self.rightAllow.frame = CGRectMake(CGRectGetMaxX(self.rightLabel.frame) + margin, 0, rightAllowW, viewHeight);
    }
}

@end
