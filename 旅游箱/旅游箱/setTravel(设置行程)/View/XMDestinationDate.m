//
//  XMDestinationDate.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMDestinationDate.h"
#define childViewHeight 50
@interface XMDestinationDate()
@property (nonatomic,weak) UIImageView *leftImage;
@property (nonatomic,weak) UILabel *contentText;
@end

@implementation XMDestinationDate

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"travel_page_reset"]]];
        
        //添加图片
        UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"travel_page_calendar_left_icon"]];
        self.leftImage = leftImage;
        [self addSubview:leftImage];
        
        //添加文字
        UILabel *contentText = [[UILabel alloc] init];
        self.contentText = contentText;
        contentText.font = [UIFont systemFontOfSize:14];
        contentText.textColor = [UIColor blackColor];
        [self addSubview:contentText];
        
    }
    return self;
}

-(void)setText:(NSString *)text
{
    _text = [text copy];
    self.contentText.text = text;
}

- (void)layoutSubviews
{
    //设置选择日期图片frame
    self.leftImage.frame = CGRectMake(0, 0, childViewHeight, childViewHeight);
    self.leftImage.contentMode = UIViewContentModeCenter;
    
    //设置选择日期字体frame
    CGFloat contentTextW = self.frame.size.width - self.leftImage.frame.size.width;
    self.contentText.frame = CGRectMake(CGRectGetMaxX(self.leftImage.frame), 0, contentTextW, childViewHeight);
    self.contentText.textAlignment = NSTextAlignmentCenter;
}
@end
