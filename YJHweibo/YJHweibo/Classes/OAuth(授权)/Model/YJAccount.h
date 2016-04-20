//
//  YJAccount.h
//  YJHweibo
//
//  Created by YJH on 16/4/9.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJAccount : NSObject
// 访问标记
@property (nonatomic,copy) NSString *access_token;
// access_token的生命周期
@property (nonatomic,copy) NSString *expires_in;
// 用户 id
@property (nonatomic,copy) NSString *uid;
// 获取(account)时间
@property (nonatomic,strong) NSDate *created_time;
// 用户昵称
@property (nonatomic,copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
