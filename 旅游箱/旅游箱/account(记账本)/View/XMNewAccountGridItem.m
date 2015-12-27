//
//  XMNewAccountGridItem.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/26.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMNewAccountGridItem.h"

#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height
@implementation XMNewAccountGridItem
-(instancetype) initWithItemName:(NSString *)itemName nomImg:(UIImage *) nomImg selectImg:(UIImage *)selectImg
{
    if (self = [super init]) {
        UIButton *imgButton = [[UIButton alloc] init];
        [imgButton setImage:nomImg forState:UIControlStateNormal];
        [imgButton setImage:selectImg forState:UIControlStateSelected];
        [imgButton addTarget:self action:@selector(imgButtonClick:) forControlEvents:UIControlEventTouchDown];
        [imgButton setAdjustsImageWhenHighlighted:NO];
        self.imgButton =  imgButton;
        [self addSubview:imgButton];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = [UIColor lightGrayColor];
        nameLabel.font = [UIFont systemFontOfSize:10];
        nameLabel.text = itemName;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
    }
    return self;
}

+(instancetype) gridItemWithName:(NSString *)itemName nomImg:(UIImage *) nomImg selectImg:(UIImage *)selectImg
{
    return [[self alloc] initWithItemName:itemName nomImg:nomImg selectImg:selectImg];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat nameSize = 10;
    self.imgButton.frame = CGRectMake(0, 0, viewWidth, viewHeight-nameSize);
    
    self.nameLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imgButton.frame), viewWidth, nameSize);
}
-(void)imgButtonClick:(UIButton *)selectButton
{
    
    [UIView animateWithDuration:0.1 animations:^{
        selectButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }completion:^(BOOL finished) {
        selectButton.transform = CGAffineTransformIdentity;
    }];
    
    if ([self.delegate respondsToSelector:@selector(gridItemButtonClick:)]) {
        [self.delegate gridItemButtonClick:self];
    }
}
@end
