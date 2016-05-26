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
#import "YJEmotion.h"
#import "MJExtension.h"
@implementation YJEmotionTool
// 全局变量
static NSMutableArray *_recentEmotions;

// 该方法只调用一次
+ (void)initialize
{
    // 加载沙盒中的表情数据
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile: YJRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}
// 归档
+ (void)addRecentEmotion:(YJEmotion *)emotion
{
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];
    
    // 将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:YJRecentEmotionsPath];

}

/**
 *  返回装着 YJEmotion模型的数组
 */
// 解档
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}


+ (YJEmotion *)emotionWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmotions];
    for (YJEmotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    NSArray *lxhs = [self lxhEmotions];
    for (YJEmotion *emotion in lxhs) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    return nil;
}

// 全局变量
static NSArray *_emojiEmotions, *_defaultEmotions, *_lxhEmotions;
+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiEmotions;
}

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhEmotions;
}




// 加载沙盒中的表情数据
//    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
//    if (emotions == nil) {
//        emotions = [NSMutableArray array];
//    }

//    [emotions removeObject:emotion];
//    for (int i = 0; i<emotions.count; i++) {
//        YJEmotion *e = emotions[i];
//
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }

//    for (HWEmotion *e in emotions) {
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }
@end
