//
//  XMMonthConsultHeader.m
//  旅游箱
//
//  Created by 梁亦明 on 15/3/31.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMMonthConsultHeader.h"

#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height
@interface XMMonthConsultHeader()
@property (nonatomic,weak) UILabel *leftLabel;
@property (nonatomic,weak) UIImageView *buttomImg;
@end

@implementation XMMonthConsultHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.font = [UIFont systemFontOfSize:15];
        leftLabel.alpha = 0.8;
        leftLabel.text = @"本月消费合计";
        leftLabel.textColor = [UIColor blackColor];
        self.leftLabel = leftLabel;
        [self addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.text = @"¥ 0";
        rightLabel.alpha = 0.7;
        rightLabel.textColor = [UIColor redColor];
        rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel = rightLabel;
        [self addSubview:rightLabel];
        
        UIImageView *buttomImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_color_line_no_shaow"]];
        self.buttomImg = buttomImg;
        [self addSubview:buttomImg];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttomViewHeight = 5;
    self.leftLabel.frame = CGRectMake(0, 0, viewWidth*0.4, viewHeight-buttomViewHeight);
    self.rightLabel.frame = CGRectMake(viewWidth * 0.4, 0, viewWidth*0.6-10, viewHeight-buttomViewHeight);
    self.buttomImg.frame = CGRectMake(0, CGRectGetMaxY(self.rightLabel.frame), viewWidth, buttomViewHeight);
}

@end
