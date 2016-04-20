//
//  YJEmotionPageView.m
//  YJYJeibo
//
//  Created by YJH on 16/4/19.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJEmotionPageView.h"
#import "YJEmotion.h"
#import "HWEmotionPopView.h"
#import "HWEmotionButton.h"
#import "YJEmotionTool.h"
@interface YJEmotionPageView()
// 点击表情后的放大镜
@property(nonatomic, strong)HWEmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation YJEmotionPageView

- (HWEmotionPopView *)popView
{
    if (!_popView) {
         HWEmotionPopView *popView = [HWEmotionPopView popView];
        
    
        self.popView = popView;
    }
    return _popView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 2.添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

// 创建表情按钮
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        HWEmotionButton *btn = [[HWEmotionButton alloc] init];
        [self addSubview:btn];
        
        // 设置表情数据
        btn.emotion = emotions[i];
      
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
    }
}

// CUICatalog: Invalid asset name supplied: (null), or invalid scale factor: 2.000000
// 警告原因：尝试去加载的图片不存在

/**
 *  监听删除按钮点击
 */
-(void)deleteClick{

   [[NSNotificationCenter defaultCenter] postNotificationName:YJEmotionDidDeleteNotification object:nil];

}

/**
 *  根据手指位置所在的表情按钮
 */
- (HWEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        HWEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            
            // 已经找到手指所在的表情按钮了，就没必要再往下遍历
            return btn;
        }
    }
    return nil;
}

/**
 *  在这个方法中处理长按手势
 */
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    // 手势所在的 view 的位置
    CGPoint location = [recognizer locationInView:recognizer.view];
    // 获得手指所在的位置\所在的表情按钮
    HWEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    // 手势状态
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled: // 手势中断
        case UIGestureRecognizerStateEnded: // 手指已经不再触摸pageView
            // 移除popView
            [self.popView removeFromSuperview];
            
            // 如果手指还在表情按钮上
            if (btn) {
                // 发出通知
                [self selectEmotion:btn.emotion];
            }
            break;
            
        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
        case UIGestureRecognizerStateChanged: { // 手势改变（手指的位置改变）
            // 显示popView
            [self.popView showFrom:btn];
            break;
        }
            
        default:
            break;
    }
}

// 表情按钮点击
-(void)btnClicks:(HWEmotionButton *)btn{
    
    
    // 显示popView
    [self.popView showFrom:btn];

    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 发出通知
    [self selectEmotion:btn.emotion];
}

/**
 *  选中某个表情，发出通知
 *
 *  @param emotion 被选中的表情
 */
- (void)selectEmotion:(YJEmotion *)emotion
{
    // 将这个表情存进沙盒
    [YJEmotionTool addRecentEmotion:emotion];
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[YJSelectEmotionKey] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:YJEmotionDidSelectNotification object:nil userInfo:userInfo];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 内边距(四周)
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / YJEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / YJEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % YJEmotionMaxCols) * btnW;
        btn.y = inset + (i / YJEmotionMaxCols) * btnH;
    }
    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.x = self.width - inset - btnW;
}
@end
