//
//  XMTarBarButton.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/5.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMTarBarButtonDelegate <NSObject>
@optional
-(void)tarBarButtonClick:(UILabel *)tarBarButton guideView:(UIImageView*)guideView;
@end

@interface XMTarBarButton : UIView
@property (nonatomic,weak) id<XMTarBarButtonDelegate> delegate;
@property (nonatomic,weak) UILabel *leftLabel;
@property (nonatomic,weak) UILabel *rightLabel;
@property (nonatomic,weak) UIImageView *guideView;
+ (instancetype) barButton;
@end
