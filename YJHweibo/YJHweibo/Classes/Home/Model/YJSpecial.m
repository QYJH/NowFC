//
//  YJSpecial.m
//  YJHweibo
//
//  Created by YJH on 16/4/27.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJSpecial.h"

@implementation YJSpecial
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
