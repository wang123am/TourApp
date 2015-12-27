//
//  XMSelectCity.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/5.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XMSelectCityDelegate <NSObject>

@optional
-(void)selectCityCallBackWithCity:(NSString *)city controllerTag:(int)tag;
@end

@interface XMSelectCity : UIViewController
@property (nonatomic,weak) id <XMSelectCityDelegate> delegate;
@property (nonatomic,assign)int tag;
@end
