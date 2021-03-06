//
//  YJEmotion.m
//  YJHweibo
//
//  Created by YJH on 16/4/18.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJEmotion.h"
#import "MJExtension.h"

@interface YJEmotion() <NSCoding>

@end
@implementation YJEmotion

//MJCodingImplementation



/**
 *  从文件中解析对象时调用
 */
// 解码
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
// 编码
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
}


/**
 *  常用来比较两个YJEmotion对象是否一样
 *
 *  @param other 另外一个YJEmotion对象
 *
 *  @return YES : 代表2个对象是一样的，NO: 代表2个对象是不一样
 */
- (BOOL)isEqual:(YJEmotion *)other
{
  return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}


@end
