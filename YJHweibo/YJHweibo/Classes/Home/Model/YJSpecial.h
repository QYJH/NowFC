//
//  YJSpecial.h
//  YJHweibo
//
//  Created by YJH on 16/4/27.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJSpecial : NSObject
/** 这段特殊文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange range;
/** 这段特殊文字的矩形框(要求数组里面存放CGRect) */
@property (nonatomic, strong) NSArray *rects;
@end
