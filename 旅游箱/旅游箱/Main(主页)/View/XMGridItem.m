//
//  XMGridItem.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMGridItem.h"

#define itemHeigth self.frame.size.height
@interface XMGridItem()

@property (nonatomic,weak) UILabel *titleItem;
@end

@implementation XMGridItem

-(instancetype) initWithImage:(UIImage *)img selectImg:(UIImage *)selectImg title:(NSString *)title
{
    if (self = [super init]) {
        //图片按钮
        UIButton *imgItem = [[UIButton alloc] init];
//        imgItem.backgroundColor = [UIColor redColor];
        self.imgItem = imgItem;
        imgItem.contentMode = UIViewContentModeCenter;
        [imgItem setImage:img forState:UIControlStateNormal];
        [imgItem setImage:selectImg forState:UIControlStateHighlighted];
        [self addSubview:imgItem];
        
        UILabel *titleItem = [[UILabel alloc] init];
//        titleItem.backgroundColor = [UIColor blueColor];
        [titleItem setText:title];
        //设置文字大小
        titleItem.font = [UIFont systemFontOfSize:11];
        titleItem.textColor = [UIColor grayColor];
        //设置文字居中
        titleItem.textAlignment = NSTextAlignmentCenter;
        self.titleItem = titleItem;
        [self addSubview:titleItem];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imgItemH = itemHeigth * 0.6;
    CGFloat imgItemW = self.frame.size.width;
    self.imgItem.frame = CGRectMake(0, 0, imgItemW, imgItemH);

    self.titleItem.frame = CGRectMake(0,imgItemH,imgItemW,20);
}

+(instancetype) itemWithImage:(UIImage *)img selectImg:(UIImage *)selectImg title:(NSString *)title
{
    return [[self alloc] initWithImage:img selectImg:selectImg title:title];
}
@end
