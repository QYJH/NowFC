//
//  YJEmotionPageView.h
//  YJYJeibo
//
//  Created by YJH on 16/4/19.
//  Copyright © 2016年 YJH. All rights reserved.
//  用来表示一页的表情（里面显示1~20个表情）

#import <UIKit/UIKit.h>
// 一页中最多3行
#define YJEmotionMaxRows 3
// 一行中最多7列
#define YJEmotionMaxCols 7
// 每一页的表情个数
#define YJEmotionPageSize ((YJEmotionMaxRows * YJEmotionMaxCols) - 1)


@interface YJEmotionPageView : UIView
/** 这一页显示的表情（里面都是YJEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;
@end
