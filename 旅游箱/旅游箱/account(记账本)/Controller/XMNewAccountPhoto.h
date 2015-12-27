//
//  XMNewAccountPhoto.h
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMNewAccountPhotoDelegate <NSObject>

@optional
-(void)deletePhotoCallBack;
@end

@interface XMNewAccountPhoto : UIViewController
@property (nonatomic,weak) UIImage *photoImg;
@property (nonatomic,weak) id <XMNewAccountPhotoDelegate> delegate;
@end
