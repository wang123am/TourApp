//
//  XMTravelassistantSetNote.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMTravelassistantSetViewDelegate <NSObject>

@optional
-(void)travelassistantSetViewButtonClick;
@end

@interface XMTravelassistantSetView : UIView
@property (nonatomic,weak) id <XMTravelassistantSetViewDelegate> delegate;
+(instancetype) setViewWithCenterImg:(UIImage *)centerImage buttonNomalImg:(UIImage *)buttonNom buttonHigImg:(UIImage *)buttonHig;
-(instancetype) initWithCenterImg:(UIImage *)centerImage buttonNomalImg:(UIImage *)buttonNom buttonHigImg:(UIImage *)buttonHig;
@end
