//
//  XMNewAccountPictItem.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/27.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMNewAccountPictItemDelegate <NSObject>
@optional
-(void)pictButtonCallBack;
@end

@interface XMNewAccountPictItem : UIView
@property (nonatomic,weak) id <XMNewAccountPictItemDelegate> delegate;
@property (nonatomic,weak) UIButton *pictButton;
@end
