//
//  YJEmotionTextView.h
//  YJHweibo
//
//  Created by YJH on 16/4/20.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJdrawRectTextView.h"

@class YJEmotion;

@interface YJEmotionTextView : YJdrawRectTextView
- (void)insertEmotion:(YJEmotion *)emotion;
- (NSString *)fullText;
@end
