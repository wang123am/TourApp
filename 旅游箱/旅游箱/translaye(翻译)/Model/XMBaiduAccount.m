//
//  XMBaiduAccount.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/21.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMBaiduAccount.h"

@implementation XMBaiduAccount
-(instancetype) initWithContent:(NSString *)content fromLanguageCode:(NSString*)fromCode toLanguageCode:(NSString *)toCode
{
    if (self = [super init]) {
        self.client_id = @"vfbzrvm3MG9hF8BjiEPGqdtK";
        self.url = @"http://openapi.baidu.com/public/2.0/bmt/translate";
        self.fromCode = fromCode;
        self.toCode = toCode;
        self.content = content;
    }
    return self;
}
+(instancetype) accountWithContent:(NSString *)content fromLanguageCode:(NSString*)fromCode toLanguageCode:(NSString *)toCode
{
    return [[self alloc] initWithContent:content fromLanguageCode:fromCode toLanguageCode:toCode];
}

-(NSMutableDictionary *) accountDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"client_id"] = self.client_id;
    dict[@"q"] = self.content;
    dict[@"from"] = self.fromCode;
    dict[@"to"] = self.toCode;
    return dict;
}
@end
