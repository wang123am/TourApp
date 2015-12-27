//
//  shareViewController.m
//  WDMVProducter
//
//  Created by 黄嘉宏 on 15-5-7.
//  Copyright (c) 2015年 wuhuan. All rights reserved.
//

#import "shareViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface shareViewController ()

@end

@implementation shareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self share];
    // Do any additional setup after loading the view.
}

-(void)share{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"about_us_page_xyz_icon" ofType:@"png"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享一款_亦明的旅行箱"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"_亦明的旅行箱"
                                                  url:@"https://github.com/lyimin"
                                          description:@"这是_亦明开发的iOS旅行箱"
                                            mediaType:SSPublishContentMediaTypeImage];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                    [self.view removeFromSuperview];
                                    [self removeFromParentViewController];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                    [self.view removeFromSuperview];
                                    [self removeFromParentViewController];
                                }
                                else if (state == SSResponseStateCancel){
                                    [self.view removeFromSuperview];
                                    [self removeFromParentViewController];
                                }
                            }];
}

@end
