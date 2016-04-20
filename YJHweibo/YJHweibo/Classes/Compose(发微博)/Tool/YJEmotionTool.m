//
//  YJEmotionTool.m
//  YJHweibo
//
//  Created by YJH on 16/4/21.
//  Copyright © 2016年 YJH. All rights reserved.
//
// 最近表情的存储路径
#define YJRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]
#import "YJEmotionTool.h"

@implementation YJEmotionTool
// 归档
+ (void)addRecentEmotion:(YJEmotion *)emotion
{
    // 加载沙盒中的表情数据
    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
    if (emotions == nil) {
        emotions = [NSMutableArray array];
    }
    
    // 将表情放到数组的最前面
    [emotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:emotions toFile:YJRecentEmotionsPath];
}

/**
 *  返回装着 YJEmotion模型的数组
 */
// 解档
+ (NSArray *)recentEmotions
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:YJRecentEmotionsPath];
}
@end
