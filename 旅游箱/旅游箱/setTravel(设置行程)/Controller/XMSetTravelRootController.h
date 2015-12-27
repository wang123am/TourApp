//
//  XMSetTravelRootController.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMBaseViewController.h"
#import "XMSetTourButton.h"
#define navigationBg [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]
@protocol XMSetTravelRootDelegate <NSObject>
@optional
-(void)setTravelCallBack:(NSString *)startPoint startDate:(NSString *)startDate endPoint:(NSString*)endPoint endFromDate:(NSString *)fromDate endToDate:(NSString *)toDate;
@end

@interface XMSetTravelRootController :XMBaseViewController
/** 开始旅游按钮*/
@property (nonatomic,weak) XMSetTourButton *startTourButton;
@property (nonatomic,weak) id<XMSetTravelRootDelegate> delegate;
@end
