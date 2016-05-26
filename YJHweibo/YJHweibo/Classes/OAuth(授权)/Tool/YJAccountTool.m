//
//  YJAccountTool.m
//  YJHweibo
//
//  Created by YJH on 16/4/9.
//  Copyright © 2016年 YJH. All rights reserved.


// 获取document目录
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
#define YJAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"account.archive"]

#import "YJAccountTool.h"
@implementation YJAccountTool
+ (void)saveAccount:(YJAccount *)account
{
#pragma mark 将返回的account数据,存入沙盒
    // 自定义对象的存储必须用 NSKeyedArchiver 不再有writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:YJAccountPath];
}


+ (YJAccount *)account
{
    // 加载模型
    YJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YJAccountPath];
 
    // 过期的时间秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间 (获取的时间 + 过期的时间)
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    // 获取当前时间
    NSDate *now = [NSDate date];
    
    // 如果 now >= expiresTime 过期
 /*  NSOrderedAscending = -1L 升序 右边 > 左边
     NSOrderedSame 一样
     NSOrderedDescending 降序  右边 < 左边
 */
    NSComparisonResult result = [expiresTime compare:now];
    if(result != NSOrderedDescending)
    {
        return nil; // 如果过期 account返回空
    }
    
    NSLog(@"expiresTime =%@ now =%@",expiresTime,now);
    return account;
}
@end
