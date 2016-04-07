//
//  YJTabBar.h
//  YJHweibo
//
//  Created by YJH on 16/3/31.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJTabBar;
// 因为YJTabBar继承自UITabBar,所以想成为YJTabBar的代理,也必须实现UITabBar的代理协议
@protocol YJTabBarDelegate <UITabBarDelegate>

@optional
-(void)tabBarDidClickPlusButton:(YJTabBar *)tabBar;
@end

@interface YJTabBar : UITabBar
@property(nonatomic,weak) id<YJTabBarDelegate>delegate;
@end
