//
//  YJEmotionTabBarButton.m
//  YJHweibo
//
//  Created by YJH on 16/4/18.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJEmotionTabBarButton.h"

@implementation YJEmotionTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        // 设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    // 按钮高亮所做的一切操作都不在了
}

@end
