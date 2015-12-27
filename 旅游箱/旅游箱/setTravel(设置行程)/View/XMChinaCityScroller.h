//
//  XMChinaCityScroller.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMChinaCityScrollerDelegate <UIScrollViewDelegate>

@optional
- (void) lastButtonHeight:(CGFloat)lastButtonHeight;
- (void) listButtonClick:(NSString *)buttonText;
@end

@interface XMChinaCityScroller : UIScrollView
+ (instancetype) scrollerWithCityArray:(NSMutableArray *)hotCityArray;
- (instancetype) initWithCityArray:(NSMutableArray *)hotCityArray;
@property (nonatomic,weak) id<XMChinaCityScrollerDelegate> delegate;
@end
