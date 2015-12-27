//
//  XMLanguageSelect.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMLanguageSelectDelegate <NSObject>
@optional
-(void) selectLanguageCallBack:(NSString *)languageName;
@end
@interface XMLanguageSelect : UITableViewController
/**
 *  选中的语言
 */
@property (nonatomic,copy) NSString * selectLanguage;
@property (nonatomic,weak) id <XMLanguageSelectDelegate> delegate;
@end
