//
//  XMSettingListModel.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    XMSettingListNormal = 0,
    XMSettingListSwitch,
    XMSettingListPhone
}XMSettingListType;

@interface XMSettingListModel : NSObject
/** 标题*/
@property (nonatomic,copy) NSString * text;
/** 图片*/
@property (nonatomic,copy) NSString * icon;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) modelWithDict:(NSDictionary *)dict;

@property (nonatomic,assign)XMSettingListType settingListType;
@end
