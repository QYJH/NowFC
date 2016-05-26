//
//  YJAccountTool.h
//  YJHweibo
//
//  Created by YJH on 16/4/9.
//  Copyright © 2016年 YJH. All rights reserved.
//  处理账号相关的所有操作,存储账号,取出账号

#import <Foundation/Foundation.h>
#import "YJAccount.h"
@interface YJAccountTool : NSObject
// 账号模型,存储账号信息
+ (void)saveAccount:(YJAccount *)account;
// 返回账号信息 (如果账号过期 返回nil)
+ (YJAccount *)account;
@end






// 将返回的数据,存入沙盒
// 获取document目录
//NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
// 自定义对象的存储必须用 NSKeyedArchiver 不再有writeToFile方法
//[NSKeyedArchiver archiveRootObject:account toFile:path];
//      [responseObject writeToFile:path atomically:YES];

#pragma mark 获取沙盒路径
//        NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *cachesDir = [doc objectAtIndex:0];
//        NSLog(@"cachesDir=%@",cachesDir);

//    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 请求数据类型
//    mager.responseSerializer =  [AFHTTPResponseSerializer serializer]; // 返回数据类型

// 获得info.plst
  //  NSDictionary *info = [NSBundle mainBundle].infoDictionary;