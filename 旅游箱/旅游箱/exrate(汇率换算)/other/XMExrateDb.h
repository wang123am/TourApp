//
//  XMExrateDb.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/24.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMExrateDb : NSObject
-(NSMutableArray *)selectAllExrateData;
-(NSString *)selectRateWithCode:(NSString *)code;
@end
