//
//  XMMainScroller.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMMainScrollerDelegate <UIScrollViewDelegate>
@optional
-(void)onMainItemClick:(long) viewTag;
@end

@interface XMMainScroller : UIScrollView
@property (nonatomic,weak) id <XMMainScrollerDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)gridItemText;
+(instancetype) scrollerWithFrame:(CGRect) frame titleArray:(NSArray *)gridItemText;

@end
