//
//  YJUser.h
//  YJHweibo
//
//  Created by YJH on 16/4/11.
//  Copyright © 2016年 YJH. All rights reserved.
// 用户模型

#import <Foundation/Foundation.h>

typedef enum {
    YJUserVerifiedTypeNone = -1, // 没有任何认证
    
    YJUserVerifiedPersonal = 0,  // 个人认证
    
    YJUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    YJUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    YJUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    YJUserVerifiedDaren = 220 // 微博达人
} YJUserVerifiedType;

@interface YJUser : NSObject
// 用户 id
@property(nonatomic,copy) NSString *idstr;
// 用户昵称
@property(nonatomic,copy) NSString *name;
// 用户头像
@property(nonatomic,copy) NSString *profile_image_url;

/** 会员类型 值 > 2 才是会员*/
@property(nonatomic,assign) int mbtype;
/** 会员等级 */
@property(nonatomic,assign) int mbrank;
@property(nonatomic,assign,getter = isVip) BOOL vip;
/** 认证类型 */
@property (nonatomic, assign) YJUserVerifiedType verified_type;
//+(instancetype)UserWithDict:(NSDictionary *)dict;
@end
