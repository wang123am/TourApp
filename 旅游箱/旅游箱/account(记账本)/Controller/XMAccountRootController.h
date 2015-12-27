//
//  XMAccountRoot.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/17.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMBaseViewController.h"

typedef enum {
    leftBarButtonItemTypeHome = 0,
    leftBarButtonItemTypeNone
}accountRootControllerLeftBarButtonItemType;

@interface XMAccountRootController : XMBaseViewController
@property (nonatomic,copy) NSString *showDate;
@property (nonatomic,assign) accountRootControllerLeftBarButtonItemType leftBarButtonItemType;
@end
