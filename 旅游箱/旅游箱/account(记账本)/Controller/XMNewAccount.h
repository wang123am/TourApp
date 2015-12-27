//
//  XMNewAccount.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/26.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMNewAccountDelegate <NSObject>

@optional
-(void)saveButtonClick;
@end

@interface XMNewAccount : UIViewController
@property (nonatomic,weak) id <XMNewAccountDelegate> delegate;
@end
