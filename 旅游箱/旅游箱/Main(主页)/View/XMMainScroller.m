//
//  XMMainScroller.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMMainScroller.h"
#import "XMGridItem.h"

#define appWidth self.frame.size.width
#define buttomScrollH self.frame.size.height
#define gridItemCount 6

@implementation XMMainScroller
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)gridItemText
{
    
    if (self = [super initWithFrame:frame]) {
        //设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_page_gridview_line"]];
        //间距
        CGFloat marginTop = 15;
        CGFloat gridItemW = appWidth / 3;
        CGFloat gridItemH = buttomScrollH * 0.5;
        //在scrollView添加按钮
        for (int i = 0 ; i < gridItemCount; i++) {
            NSString *itemNormalName = [NSString stringWithFormat:@"main_page_griditem_%02d",i+1];
            NSString *itemHighlightName = [NSString stringWithFormat:@"main_page_griditem_%02d_pressed",i+1];
            //创建自定义按钮
            XMGridItem *gridItem = [XMGridItem itemWithImage:[UIImage imageNamed:itemNormalName] selectImg:[UIImage imageNamed:itemHighlightName] title:gridItemText[i]];
            gridItem.imgItem.tag = i;
            //设置按钮frame
            int col = i / 3;
            int line = i % 3;
            CGFloat gridItemX = line * gridItemW;
            CGFloat gridItemY = col * gridItemH + marginTop;
            gridItem.frame = CGRectMake(gridItemX, gridItemY, gridItemW, gridItemH);
            [self addSubview:gridItem];
            //添加按钮点击
            [gridItem.imgItem addTarget:self action:@selector(onGridItemClick:) forControlEvents:UIControlEventTouchUpInside];
        }
       
        //设置scroller滚动范围
        self.contentSize = CGSizeMake(gridItemCount * gridItemW * 0.5 , 0);
        //隐藏滚动条
        self.showsHorizontalScrollIndicator = NO;
        //设置分页
        self.pagingEnabled = YES;
    }
    return self;
}

+(instancetype)scrollerWithFrame:(CGRect)frame titleArray:(NSArray *)gridItemText
{
    return [[self alloc] initWithFrame:frame titleArray:gridItemText];
}

-(void)onGridItemClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(onMainItemClick:)]) {
        [self.delegate onMainItemClick:button.tag];
    }
}
@end
