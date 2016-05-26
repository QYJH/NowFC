//
//  YJHttpTool.m
//  YJHweibo
//
//  Created by YJH on 16/4/14.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJHttpTool.h"
#import "AFNetworking.h"

@implementation YJHttpTool
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
        AFHTTPRequestOperationManager *mager = [AFHTTPRequestOperationManager manager];
        [mager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                //  success 所包含的代码块,在这调用
                // responseObject 传给了 success,外面的 success == responseObject
                success(responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
}


+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            // success 所包含的代码块,在这调用
            // responseObject 传给了 success,外面的 success == responseObject
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
