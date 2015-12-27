//
//  XMDestinationView.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMDestinationView.h"
#import "XMTimer.h"

#define viewWidth self.frame.size.width
#define textMargin 20
#define childViewHeight 50
#define viewMargin 1

@interface XMDestinationView ()
@property (nonatomic,weak) UIImageView *airView;
@property (nonatomic,weak) UIImageView *leftImage;
@property (nonatomic,weak) UILabel *contentText;
@end

@implementation XMDestinationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //目的地选择
        XMSelectData *selectCity = [[XMSelectData alloc] initWithLeftImg:[UIImage imageNamed:@"travel_page_listitem_first"] leftText:@"目的地1" rightText:@"请选择" rightImg:[UIImage imageNamed:@"travel_page_listitem_right_icon_arrow"]];
        self.selectCity = selectCity;
        [self addSubview:selectCity];
        
        //从什么时间
        XMDestinationDate *fromDateView = [[XMDestinationDate alloc] init];
        fromDateView.text = [XMTimer tomorrow];
        self.fromDateView = fromDateView;
        [self addSubview:fromDateView];
        
        //中间图片
        UIImageView *airView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"travel_page_listitem_plane"]];
        self.airView = airView;
        [self addSubview:airView];
        //到什么时间
        XMDestinationDate *toDateView = [[XMDestinationDate alloc] init];
        toDateView.text = [XMTimer tomorrow];
        self.toDateView = toDateView;
        [self addSubview:toDateView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置目的地选择frame
    self.selectCity.frame = CGRectMake(0, 0, viewWidth, childViewHeight);
    
    //时间1 frame
    CGFloat photoSize = 50;
    CGFloat fromDateViewW = (viewWidth - 2*viewMargin - photoSize) / 2;
    CGFloat fromDateViewY = CGRectGetMaxY(self.selectCity.frame) + viewMargin;
    self.fromDateView.frame = CGRectMake(0, fromDateViewY, fromDateViewW, childViewHeight);
    
    //图片frame
    CGFloat photoX = CGRectGetMaxX(self.fromDateView.frame) + viewMargin;
    self.airView.frame = CGRectMake(photoX, fromDateViewY, photoSize, photoSize);
    
    //时间2 frame
    CGFloat toDateViewX = CGRectGetMaxX(self.airView.frame) + viewMargin;
    self.toDateView.frame = CGRectMake(toDateViewX, fromDateViewY, fromDateViewW, childViewHeight);
    
}

@end
