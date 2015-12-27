//
//  XMNewAccountComments.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/28.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMNewAccountCommentsDelegate <NSObject>
-(void)commentsCallBackWithText:(NSString *)text;
@end

@interface XMNewAccountComments : UIViewController
@property (nonatomic,copy) NSString * text;
@property (nonatomic,weak) id <XMNewAccountCommentsDelegate> delegate;
/** 标题*/
@property (nonatomic,copy) NSString * controllerTitle;
@end
