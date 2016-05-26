//
//  YJStatusTool.h
//  YJHweibo
//
//  Created by YJH on 16/5/4.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJStatusTool : NSObject
/**
 *  根据请求参数去沙盒中加载缓存的微博数据
 *
 *  @param params 请求参数
 */
+ (NSArray *)statusesWithParams:(NSDictionary *)params;

/**
 *  存储微博数据到沙盒中
 *
 *  @param statuses 需要存储的微博数据
 */
+ (void)saveStatuses:(NSArray *)statuses;
@end
