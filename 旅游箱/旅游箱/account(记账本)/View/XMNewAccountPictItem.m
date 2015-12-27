//
//  XMNewAccountPictItem.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/27.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMNewAccountPictItem.h"
#import "UIImage+XM.h"

#define viewHeight self.frame.size.height
#define viewWidth self.frame.size.width


@implementation XMNewAccountPictItem

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewHeight, viewHeight)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"相片";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIButton *pictButton = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth-10-viewHeight, 0, viewHeight, viewHeight)];
        self.pictButton = pictButton;
        [pictButton addTarget:self action:@selector(pictButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [pictButton setImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_add_page_add_pic"] size:CGSizeMake(40, 40)] forState:UIControlStateNormal];
        [self addSubview:pictButton];
        
    }
    return  self;
}

-(void)pictButtonClick
{
    if ([self.delegate respondsToSelector:@selector(pictButtonCallBack)]) {
        [self.delegate pictButtonCallBack];
    }
}

@end
