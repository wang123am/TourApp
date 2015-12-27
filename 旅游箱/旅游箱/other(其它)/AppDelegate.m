//
//  AppDelegate.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/2.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "AppDelegate.h"
#import "XMMainController.h"
#import "XMAppStart.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [XMAppStart appStart];
    //隐藏状态栏
    [application setStatusBarHidden:NO];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    //设置根控制器
    self.window.rootViewController = [[XMMainController alloc] init];
    
    [self initwithShareSDK];
    return NO;
}

-(void) initwithShareSDK {
    [ShareSDK registerApp:@"bc809a0f7da0"];
    
    // 新浪
    [ShareSDK connectSinaWeiboWithAppKey:@"3833970127" appSecret:@"c1d615f48b88d0b8a4298590e16e6ff2" redirectUri:@"https://github.com/lyimin" weiboSDKCls:[WeiboSDK class]];
    // qq 和 qq空间
//    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
//    [ShareSDK connectQQWithQZoneAppKey:@"1104865387" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    [ShareSDK connectQQWithAppId:@"1104865387" qqApiCls:[QQApiInterface class]];
    [ShareSDK connectQZoneWithAppKey:@"1104865387" appSecret:@"0Ni4htaIueOKoGE7" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
//    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
//    [ShareSDK connectQZoneWithAppKey:@"1104865387"
//                           appSecret:@"0Ni4htaIueOKoGE7"
//                   qqApiInterfaceCls:[QQApiInterface class]
//                     tencentOAuthCls:[TencentOAuth class]];
//    
//    //添加QQ应用  注册网址   http://mobile.qq.com/api/
//    [ShareSDK connectQQWithQZoneAppKey:@"1104865387"
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
