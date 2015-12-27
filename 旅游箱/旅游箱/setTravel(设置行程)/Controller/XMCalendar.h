//
//  XMCalendar.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/8.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMCalendarDelegate <NSObject>

@optional
-(void) seletorDateCallBack:(NSString *)date viewTag:(int) tag;
@end

@interface XMCalendar : UIViewController
@property (nonatomic,weak) id<XMCalendarDelegate> delegate;
@property (nonatomic,assign)int tag;
@end
