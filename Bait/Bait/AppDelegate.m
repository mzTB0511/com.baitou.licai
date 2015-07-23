//
//  AppDelegate.m
//  Bait
//
//  Created by 刘轩 on 15/6/22.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
#import "UMSocial.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //配置友盟统计
    [self action_setupUmeng];
    
    //配置友盟渠道推广
    // [UMTrack registerUserIDFAWithUMTrck];
    
    //配置微信分享
    [self action_setupWeixin];
    
    return YES;
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




#pragma mark - 其他方法

/**
 *  配置友盟统计
 */
- (void) action_setupUmeng {
    [MobClick startWithAppkey:UMeng_App_Key reportPolicy:REALTIME channelId:UMeng_Channel];
}

/**
 *  配置友盟微信分享
 */
- (void) action_setupWeixin {
    [UMSocialData setAppKey:WX_App_ID];
    [UMSocialWechatHandler setWXAppId:WX_App_ID appSecret:WX_App_Secret url:nil];
    [WXApi registerApp:WX_App_ID];
}


#pragma mark - 回调

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


@end
