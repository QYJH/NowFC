//
//  AppDelegate.m
//  YJHweibo
//
//  Created by YJH on 16/3/22.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "AppDelegate.h"
#import "YJTabBarController.h"
#import "YJNewViewController.h"
#import "YJOAuthViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    self.window.rootViewController = [[YJOAuthViewController alloc]init];
    
//    // 上次版本
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"CFBundleVersion"];
//
//    // 当前版本从info.plst获得
////  NSDictionary *info = [NSBundle mainBundle].infoDictionary;
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    
//    if ([currentVersion isEqualToString:lastVersion]) { // 版本相同
//        self.window.rootViewController = [[YJTabBarController alloc]init];
//    }else{
//        self.window.rootViewController = [[YJNewViewController alloc]init];
//        // 将当前版本号存储到沙盒
//        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:@"CFBundleVersion"];
//        [[NSUserDefaults standardUserDefaults] synchronize];// 马上同步
//    }
    
    [self.window makeKeyAndVisible];// 让窗口可见
    
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

@end
