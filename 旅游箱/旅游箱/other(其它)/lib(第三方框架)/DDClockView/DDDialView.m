//
//  DialView.m
//  Clock
//
//  Created by dxl dxl on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DDDialView.h"

#ifndef TransformRadian
#define TransformRadian(angle) (angle) *M_PI/180.0f
#endif

@interface DDDialView(){

    CGPoint _centreCircle;
}

@end

@implementation DDDialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor =[UIColor clearColor];
        
//        _centreCircle =;

        float hw =MIN(frame.size.width, frame.size.height);
        
        _centreCircle =CGPointMake(hw/2, hw/2);
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
//    _centreCircle =CGPointMake(100.0f, 100.0f);
    
    float r =75.0f;
    
    float spaceToCircle =2.0f;
    
    float heightOfHour =15.0f;
    
    float heightOfMinute =7.0f;
    
    UIColor *_fillColor =[UIColor colorWithRed:17/255.0 green:25/255.0 blue:68/255.0 alpha:0.8];

	CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, _centreCircle.x, _centreCircle.y, r, 0, 2*M_PI, false);
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:0.8f alpha:1.0] CGColor]);
	CGContextSetFillColorWithColor(c, [_fillColor CGColor]);
	
	CGContextAddPath(c, path);
	CGContextDrawPath(c, kCGPathFillStroke);
    
    //
    CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:1.0f alpha:1.0] CGColor]);
    CGContextSetLineWidth(c, 2.0f);
    
    float angleOfHour =30.0f;
    
    CGContextScaleCTM(c, 1, -1);
    CGContextTranslateCTM(c, 0, -rect.size.height);
    
    for (int i=0; i<12; i++) {
        
        float radian =TransformRadian(angleOfHour *i);
        
        //字体大小
        float fontSize =20.0f;
        
        //t 为数字与刻度之间的间隔
        float t =14.0f;
        
        CGPoint p1 =CGPointMake(_centreCircle.x +(r -spaceToCircle)*sinf(radian), _centreCircle.y +(r -spaceToCircle) *cosf(radian));
        
        CGPoint p2 =CGPointMake(_centreCircle.x +(r -spaceToCircle -heightOfHour)*sinf(radian), _centreCircle.y +(r -spaceToCircle -heightOfHour) *cosf(radian));
        
        CGPoint p3 =CGPointMake(_centreCircle.x +(r -spaceToCircle -heightOfHour -t)*sinf(radian), _centreCircle.y +(r -spaceToCircle -heightOfHour -t) *cosf(radian));
        
        CGContextMoveToPoint(c, p1.x, p1.y);
        CGContextAddLineToPoint(c, p2.x, p2.y);
        
        CGContextSaveGState(c);
        
        [[UIColor whiteColor] set];
        
        NSString *strAngle =[NSString stringWithFormat:@"%d",(i ==0)?12:i];
    
        CGPoint p4 =CGPointMake(p3.x -[strAngle length] *fontSize/4, p3.y -fontSize/3);
        
        CGContextSelectFont(c, "Helvetica", fontSize, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(c, kCGTextFill);

        CGContextShowTextAtPoint(c, p4.x, p4.y, [strAngle UTF8String], [strAngle length]);
        
        CGContextRestoreGState(c);
    }
    
    float angleOfMinute =6.0f;
    
    for (int i=0; i<60; i++) {
        
        float radian =TransformRadian(angleOfMinute *i);
        
        CGPoint p1 =CGPointMake(_centreCircle.x +(r -spaceToCircle)*sinf(radian), _centreCircle.y -(r -spaceToCircle) *cosf(radian));
        
        CGPoint p2 =CGPointMake(_centreCircle.x +(r -spaceToCircle -heightOfMinute)*sinf(radian), _centreCircle.y -(r -spaceToCircle -heightOfMinute) *cosf(radian));
        
        CGContextMoveToPoint(c, p1.x, p1.y);
        CGContextAddLineToPoint(c, p2.x, p2.y);

    }
    
    CGContextDrawPath(c, kCGPathFillStroke);
    
    CGPathRelease(path);
    
}


@end
