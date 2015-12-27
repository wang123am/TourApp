//
//  XMSetTravelTool.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/9.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSetTravelTool.h"

@implementation XMSetTravelTool

+(void) showToast:(NSString *)message view:(UIView *)view
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.labelText = message;
    HUD.mode = MBProgressHUDModeText;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

@end
