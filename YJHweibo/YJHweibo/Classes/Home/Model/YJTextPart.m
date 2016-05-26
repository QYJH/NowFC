//
//  YJTextPart.m
//  YJHweibo
//
//  Created by YJH on 16/4/25.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJTextPart.h"

@implementation YJTextPart
// 重写description方法,打印具体信息
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
