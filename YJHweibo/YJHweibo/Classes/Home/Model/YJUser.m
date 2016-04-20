//
//  YJUser.m
//  YJHweibo
//
//  Created by YJH on 16/4/11.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJUser.h"

@implementation YJUser

-(void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}




//-(BOOL)isVip
//{
//    return self.mbrank  > 2;
//}



//+(instancetype)UserWithDict:(NSDictionary *)dict
//{
//    YJUser *user = [[YJUser alloc]init];
//    user.idstr = dict[@"idstr"];
//    user.name = dict[@"name"];
//    user.profile_image_url = dict[@"profile_image_url"];
//    
//    return user;
//}



@end
