//
//  HWEmotionPopView.h
//  黑马微博2期
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJEmotion,HWEmotionButton;
@interface HWEmotionPopView : UIView
+ (instancetype)popView;

@property (nonatomic, strong) YJEmotion *emotion;
- (void)showFrom:(HWEmotionButton *)button;
@end
