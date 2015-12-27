//
//  XMLetterCity.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMLetterCityDelegate <UITableViewDelegate>
@optional
-(void) letterCityCallBackWithCityName:(NSString *)cityName;
@end

@interface XMLetterCity : UITableViewController
@property (nonatomic,copy) NSString * navTitle;
@property (nonatomic,weak) id <XMLetterCityDelegate> delegate;
@end
