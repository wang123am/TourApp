//
//  XMLanguageModel.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLanguageModel : NSObject
@property (nonatomic,copy) NSString *languageName;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *langCode;
@property (nonatomic,copy) NSString *baiduLangCode;
@property (nonatomic,copy) NSString * country;
@property (nonatomic,assign,getter=isSelect)BOOL select;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) modelWithDict:(NSDictionary *)dict;
@end
