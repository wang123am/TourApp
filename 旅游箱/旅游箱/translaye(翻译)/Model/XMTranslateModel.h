//
//  XMTranslateModel.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/21.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMTranslateModel : NSObject
/**
 *  原来的语言
 */
@property (nonatomic,copy) NSString * from;
/**
 *  翻译后的语言
 */
@property (nonatomic,copy) NSString * to;
/**
 *  要翻译的文段
 */
@property (nonatomic,copy) NSString * src;
/**
 *  翻译后的文段
 */
@property (nonatomic,copy) NSString * dst;

-(instancetype) initWithDict:(NSMutableDictionary *)dict;
+(instancetype) modelWithDict:(NSMutableDictionary *)dict;
@end
