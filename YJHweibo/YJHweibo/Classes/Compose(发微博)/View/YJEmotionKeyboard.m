//
//  YJEmotionKeyboard.m
//  YJYJeibo
//
//  Created by YJH on 16/4/18.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJEmotionKeyboard.h"
#import "YJEmotionListView.h"
#import "YJEmotionTabBar.h"
#import "YJEmotion.h"
#import "MJExtension.h"
#import "YJEmotionTool.h"
@interface YJEmotionKeyboard() <YJEmotionTabBarDelegate>
@property (nonatomic,strong) YJEmotionTabBar *tabBar;
/** 保存正在显示listView */
@property (nonatomic, weak) YJEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) YJEmotionListView *recentListView;
@property (nonatomic, strong) YJEmotionListView *defaultListView;
@property (nonatomic, strong) YJEmotionListView *emojiListView;
@property (nonatomic, strong) YJEmotionListView *lxhListView;
@end

@implementation YJEmotionKeyboard
#pragma mark - 懒加载
- (YJEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[YJEmotionListView alloc] init];
        // 加载沙盒中的数据
        self.recentListView.emotions = [YJEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (YJEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[YJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        // 将字典数组转换为模型数组
        self.defaultListView.emotions = [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}

- (YJEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[YJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        // 将字典数组转换为模型数组
        self.emojiListView.emotions = [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (YJEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[YJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        // 将字典数组转换为模型数组
        self.lxhListView.emotions = [YJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

#pragma mark - 初始化
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.contentView
//        UIView *contentView = [[UIView alloc] init];
//        [self addSubview:contentView];
//        self.contentView = contentView;
        
        // 2.tabbar
        YJEmotionTabBar *tabBar = [[YJEmotionTabBar alloc]init];
        tabBar.delegate = self;
        [self addSubview: tabBar ];
        self.tabBar = tabBar;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1. tabBar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
    
//    // 3.设置 frame
//    UIView *child = [self.contentView.subviews lastObject];
//    child.frame = self.contentView.bounds;
    
    YJLog(@"layoutSubviews =%@",self.subviews);
}

#pragma mark - YJEmotionTabBarDelegate
- (void)emotionTabBar:(YJEmotionTabBar *)tabBar didSelectButton:(YJEmotionTabBarButtonType)buttonType
{
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];

#warning 在case里面定义变量需要加大括号!
    // 根据按钮类型，切换contentView上面的listview
    switch (buttonType) {
        case YJEmotionTabBarButtonTypeRecent: // 最近
            [self addSubview:self.recentListView];
            YJLog(@"最近");
            break;
            
        case YJEmotionTabBarButtonTypeDefault: // 默认
             [self addSubview:self.defaultListView];
            YJLog(@"默认");
            break;
            
        case YJEmotionTabBarButtonTypeEmoji: // Emoji
            [self addSubview:self.emojiListView];
            YJLog(@"Emoji");
            break;

        case YJEmotionTabBarButtonTypeLxh:{ // Lxh
            [self addSubview:self.lxhListView];
            YJLog(@"Lxh");
            break;
        }
    }
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
// 重新计算子控件的frame(setNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews，重新布局子控件)
    [self setNeedsLayout];
}

@end
