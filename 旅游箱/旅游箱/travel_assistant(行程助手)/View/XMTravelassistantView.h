//
//  XMTravelassistantView.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMTravelassistantTitleView.h"
@class XMTravelassistantItem,XMTravelassistantModel;

@protocol XMTravelassistantViewDelegate <NSObject>
@optional
-(void) travelassistantItemClickWithSuperViewId:(NSInteger)superViewId clickViewId:(NSInteger) clickViewId;
@end

@interface XMTravelassistantView : UIView
/** 添加标题*/
@property (nonatomic,weak) XMTravelassistantTitleView *titleView;
/** 添加当天消费条目*/
@property (nonatomic,weak) XMTravelassistantItem *consumeItem;
/** 添加笔记提醒条目*/
@property (nonatomic,weak) XMTravelassistantItem *noteItem;
/** 添加景点规划*/
@property (nonatomic,weak) XMTravelassistantItem *sceneItem;
/** 添加酒店住宿*/
@property (nonatomic,weak) XMTravelassistantItem *hotelItem;
/** 旅行日记*/
@property (nonatomic,weak) XMTravelassistantItem *diaryItem;

@property (nonatomic,weak) id <XMTravelassistantViewDelegate> delegate;

-(instancetype) initWithModel:(XMTravelassistantModel *)model dayNumber:(NSString *)dayNumber;
+(instancetype) viewWithModel:(XMTravelassistantModel *)model dayNumber:(NSString *)dayNumber;

@property (nonatomic,strong) XMTravelassistantModel *model;

- (void) setupDataWithTime:(NSString *)time point:(NSString *) point;
@end
