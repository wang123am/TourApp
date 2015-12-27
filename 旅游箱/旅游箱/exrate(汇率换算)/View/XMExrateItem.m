//
//  XMExrateItem.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/23.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMExrateItem.h"

#define fontSize
#define itemWidth self.frame.size.width
#define itemHeight self.frame.size.height
@implementation XMExrateItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *exrateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.exrateButton = exrateButton;
        [exrateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        exrateButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [exrateButton addTarget:self action:@selector(exrateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:exrateButton];
        
        UIImageView *verView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exrate_ver"]];
        self.verView = verView;
        verView.contentMode = UIViewContentModeCenter;
        [self addSubview:verView];
        
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.text = @"0";
        numberLabel.textAlignment = NSTextAlignmentRight;
        self.numberLabel = numberLabel;
        numberLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:numberLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.exrateButton.frame = CGRectMake(0, 0, itemHeight, itemHeight);
    
    CGFloat verViewX = CGRectGetMaxX(self.exrateButton.frame) + 10;
    self.verView.frame = CGRectMake(verViewX, 0, 1, itemHeight);

    CGFloat numberLabelX = CGRectGetMaxX(self.verView.frame);
    CGFloat numberLabelW = itemWidth - numberLabelX - 20;
    self.numberLabel.frame = CGRectMake(numberLabelX, 0, numberLabelW, itemHeight);
}

-(void)exrateButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(exrateButtonClick:)]) {
        [self.delegate exrateButtonClick:button];
    }
}
@end
