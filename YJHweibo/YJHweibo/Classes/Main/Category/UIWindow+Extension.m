//
//  UIWindow+Extension.m
//  YJHweibo
//
//  Created by YJH on 16/4/9.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "YJTabBarController.h"
#import "YJNewViewController.h"
@implementation UIWindow (Extension)
- (void)switchRootViewController
{
    // 上次版本
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"CFBundleVersion"];
    
    // 当前版本从info.plst获得
    //  NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
   
    if ([currentVersion isEqualToString:lastVersion]) { // 版本相同
        self.rootViewController = [[YJTabBarController alloc]init];
    }else{
        self.rootViewController = [[YJNewViewController alloc]init];
        // 将当前版本号存储到用户偏好设置
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];// 马上同步
   }
}
@end
