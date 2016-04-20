//
//  YJAccount.m
//  YJHweibo
//
//  Created by YJH on 16/4/9.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJAccount.h"
#import "MJExtension.h"
@implementation YJAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict{

    YJAccount *account = [[YJAccount alloc]init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    // 获取账号存储时间
    account.created_time = [NSDate date];
    return account;
}



MJCodingImplementation
//// 当一个对象要归档到沙盒中时
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.access_token forKey:@"access_token"];
//    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
//    [encoder encodeObject:self.uid forKey:@"uid"];
//    [encoder encodeObject:self.created_time forKey:@"created_time"];
//    [encoder encodeObject:self.name forKey:@"name"];
//}
//// 当从沙盒中解档一个对象时
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if(self = [super init]){
//        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
//        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
//        self.uid = [aDecoder decodeObjectForKey:@"uid"];
//        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//    }
//    return self;
//}
@end
