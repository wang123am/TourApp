//
//  XMBaiduAccount.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/21.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMBaiduAccount : NSObject
/** 开发者id*/
@property (nonatomic,copy) NSString * client_id;
/** url*/
@property (nonatomic,copy) NSString * url;
/** fromCode*/
@property (nonatomic,copy) NSString * fromCode;
/** toCode*/
@property (nonatomic,copy) NSString * toCode;
/** 内容*/
@property (nonatomic,copy) NSString * content;

-(instancetype) initWithContent:(NSString *)content fromLanguageCode:(NSString*)fromCode toLanguageCode:(NSString *)toCode;
+(instancetype) accountWithContent:(NSString *)content fromLanguageCode:(NSString*)fromCode toLanguageCode:(NSString *)toCode;

-(NSMutableDictionary *) accountDict;
@end
