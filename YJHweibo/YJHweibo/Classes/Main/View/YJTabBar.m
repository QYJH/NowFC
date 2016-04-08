//
//  YJTabBar.m
//  YJHweibo
//
//  Created by YJH on 16/3/31.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJTabBar.h"
@interface YJTabBar ()

@property(nonatomic,weak) UIButton *plusBtn;

@end
@implementation YJTabBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加按钮到 tabbar 中
        UIButton *plusBtn = [[UIButton alloc]init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [self addSubview:plusBtn];
        
        self.plusBtn = plusBtn;
    }
    return self;
}
// 加号按钮点击
-(void)plusClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)] ) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
  
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置加号按钮位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    // 2. 设置其他TabBarButton的位置和尺寸
    CGFloat TabBarButtonW = self.width / 5;
    CGFloat TabBarButtonIndex = 0;
    for (UIView *chlid in self.subviews) {
                Class class = NSClassFromString(@"UITabBarButton");
                if ([chlid isKindOfClass:class]) {
                    chlid.width = TabBarButtonW;
                    chlid.x = TabBarButtonIndex * TabBarButtonW;
        
                    // 增加索引
                    TabBarButtonIndex ++;
                    if (TabBarButtonIndex == 2) {
                        TabBarButtonIndex ++;
                    }
                }
            }
}

@end
