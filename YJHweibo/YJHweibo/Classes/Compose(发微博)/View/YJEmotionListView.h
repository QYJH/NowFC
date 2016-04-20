//
//  YJEmotionListView.h
//  YJHweibo
//
//  Created by YJH on 16/4/18.
//  Copyright © 2016年 YJH. All rights reserved.
//  表情键盘顶部的表情内容（显示所有表情的）

// 每一页的表情个数
#define YJEmotionPageSize 20

#import <UIKit/UIKit.h>

@interface YJEmotionListView : UIView
/** 表情(里面存放的YJEmotion模型) */
@property (nonatomic, strong) NSArray *emotions;
@end
