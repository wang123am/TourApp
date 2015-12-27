//
//  XMExrateModel.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/23.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMExrateModel : NSObject
/** 币种符号*/
@property (nonatomic,copy) NSString * symbol;
/** 币种汇率*/
@property (nonatomic,copy) NSString *rate;
/** 币种中文名*/
@property (nonatomic,copy) NSString *coin;
/** 币种代码*/
@property (nonatomic,copy) NSString *code;
/** 是否被选中*/
@property (nonatomic,assign,getter=isSelect)BOOL select;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)exrateWithDict:(NSDictionary *)dict;
@end
