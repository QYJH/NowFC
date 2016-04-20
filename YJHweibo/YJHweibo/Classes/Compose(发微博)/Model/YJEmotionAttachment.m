//
//  YJEmotionAttachment.m
//  YJHweibo
//
//  Created by YJH on 16/4/20.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJEmotionAttachment.h"
#import "YJEmotion.h"
@implementation YJEmotionAttachment
- (void)setEmotion:(YJEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
