//
//  NSString+Extension.h
//  YJHweibo
//
//  Created by YJH on 16/4/19.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  计算当前文件\文件夹的内容大小
 */
- (NSInteger)fileSize;
@end
