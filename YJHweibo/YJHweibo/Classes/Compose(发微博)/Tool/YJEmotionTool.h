//
//  YJEmotionTool.h
//  YJHweibo
//
//  Created by YJH on 16/4/21.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJEmotion;

@interface YJEmotionTool : NSObject
+ (void)addRecentEmotion:(YJEmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;


/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (YJEmotion *)emotionWithChs:(NSString *)chs;

@end
