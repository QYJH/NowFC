//
//  YJStatus.h
//  YJHweibo
//
//  Created by YJH on 16/4/11.
//  Copyright © 2016年 YJH. All rights reserved.
// 微博模型

#import <Foundation/Foundation.h>



@class YJUser;
@interface YJStatus : NSObject
// 用户 id
@property(nonatomic,copy) NSString *idstr;
// 微博内容
@property(nonatomic,copy) NSString *text;
// 作者信息字段
@property(nonatomic,strong) YJUser *user;
// 微博时间
@property(nonatomic,copy) NSString *created_at;
// 微博来源
@property(nonatomic,copy) NSString * source;

/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong) YJStatus *retweeted_status;


/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;
//+(instancetype)statusWintDict:(NSDictionary *)dict;
@end
