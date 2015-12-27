//
//  XMSetupCity.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/13.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMSetupCityDelegate <NSObject>
@optional
-(void)setupcityNowClick;
@end

@interface XMSetupCity : UIView
@property (nonatomic,weak) id <XMSetupCityDelegate> delegate;
@end
