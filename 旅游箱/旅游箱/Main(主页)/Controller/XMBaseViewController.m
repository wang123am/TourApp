//
//  XMBaseViewController.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMBaseViewController.h"
#import "UIBarButtonItem+XM.h"
#define navigationBg [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]

@implementation XMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = navigationBg;
    //添加导航左边按钮
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"about_us_page_xyz_icon"] selectorImg:[UIImage imageNamed:@"about_us_page_xyz_icon_pressed"] target:self action:@selector(onLeftBarButtonClick)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

#pragma mark -导航按钮点击事件
-(void)onLeftBarButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
