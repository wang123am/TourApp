//
//  SYCalendarDayView.m
//  Seeyou
//
//  Created by upin on 13-10-22.
//  Copyright (c) 2013年 linggan. All rights reserved.
//

#import "LKCalendarDayView.h"
#import "LKCalendarDefine.h"

@interface LKCalendarDayView()
@property(weak,nonatomic)UIImageView* selectedView;
/** */
@property (nonatomic,weak) UIImageView *redBackground;
@end

@implementation LKCalendarDayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroupView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_backgroupView];
    
        self.lb_date = [[UILabel alloc]initWithFrame:CGRectMake(0,self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height * 0.5)];
        _lb_date.backgroundColor = [UIColor clearColor];
        _lb_date.font = [UIFont systemFontOfSize:14];
        _lb_date.textColor = [UIColor grayColor];
        _lb_date.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lb_date];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selected = YES;
    if([self.delegate respondsToSelector:@selector(calendarDayViewWillSelected:)])
    {
       [self.delegate calendarDayViewWillSelected:self];
    }
}
-(void)setDate:(NSDate *)date
{
    _date = [date copy];
    NSDateComponents* dateComponents = [currentLKCalendar components:NSCalendarUnitDay fromDate:_date];
    _lb_date.text = [NSString stringWithFormat:@"%ld",dateComponents.day];
}

//选中时调用
-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    if(_selected)
    {
        if(self.selectedView == nil)
        {
            UIImageView* maskview = [[UIImageView alloc]initWithFrame:self.bounds];
            UIImage* maskImage =  [UIImage imageNamed:@"c_seletebox"];
            maskview.image = [maskImage stretchableImageWithLeftCapWidth:maskImage.size.width/2 topCapHeight:maskImage.size.height/2];
            [self addSubview:maskview];
            self.selectedView = maskview;
        }
    }
    else
    {
        [self.selectedView removeFromSuperview];
        self.selectedView = nil;
    }
}
@end














