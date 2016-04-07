//
//  UIBarButtonItem+Extension.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/* 创建一个 item
 target   点击item后调用哪个对象的方法
 action   点击item调用target的哪个方法
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    // 设置导航栏上面内容
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置按钮尺寸,为图片原始尺寸
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
