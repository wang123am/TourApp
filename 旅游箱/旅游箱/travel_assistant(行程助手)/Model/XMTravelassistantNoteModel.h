//
//  XMTravelassistantNoteModel.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMTravelassistantNoteModel : NSObject
/** 内容*/
@property (nonatomic,copy) NSString * noteText;
/** 笔记时间*/
@property (nonatomic,copy) NSString * noteTime;
/** 城市*/
@property (nonatomic,copy) NSString * cityType;
@end
