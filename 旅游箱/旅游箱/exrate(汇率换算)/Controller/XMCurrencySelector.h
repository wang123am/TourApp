//
//  XMCurrencySelector.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/24.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMCurrencySelectorDelegate <NSObject>

@optional
-(void) currencySelectorCallBack:(NSString *)currencyName;
@end

@interface XMCurrencySelector : UITableViewController
@property (nonatomic,copy) NSString * currentExrate;
@property (nonatomic,weak) id <XMCurrencySelectorDelegate> delegate;
@end
