//
//  YJEmotionTabBar.h
//  YJHweibo
//
//  Created by YJH on 16/4/18.
//  Copyright © 2016年 YJH. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>
typedef enum {
    YJEmotionTabBarButtonTypeRecent, // 最近
    YJEmotionTabBarButtonTypeDefault, // 默认
    YJEmotionTabBarButtonTypeEmoji, // emoji
    YJEmotionTabBarButtonTypeLxh, // 浪小花
} YJEmotionTabBarButtonType;

@class YJEmotionTabBar;

@protocol YJEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(YJEmotionTabBar *)tabBar didSelectButton:(YJEmotionTabBarButtonType)buttonType;
@end
@interface YJEmotionTabBar : UIView
@property (nonatomic, weak) id<YJEmotionTabBarDelegate> delegate;
@end
