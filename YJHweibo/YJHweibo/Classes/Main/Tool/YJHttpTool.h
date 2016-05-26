//
//  YJHttpTool.h
//  YJHweibo
//
//  Created by YJH on 16/4/14.
//  Copyright © 2016年 YJH. All rights reserved.
// 网络请求工具类,负责整个项目的网络请求

#import <Foundation/Foundation.h>

@interface YJHttpTool : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
