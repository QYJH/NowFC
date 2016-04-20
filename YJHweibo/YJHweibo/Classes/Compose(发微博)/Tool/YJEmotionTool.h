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
@end
