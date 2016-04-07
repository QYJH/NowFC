//
//  YJTabBarController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJHomeViewController.h"
#import "YJMessageViewController.h"
#import "YJDiscoverViewController.h"
#import "YJProfileViewController.h"
#import "YJNavigationController.h"
#import "YJTabBar.h"
@interface YJTabBarController ()<YJTabBarDelegate>

@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   // 1.初始化控制器
    YJHomeViewController *home = [[YJHomeViewController alloc]init];
    [self addChildVC:home title:@"首页" image:@"tabbar_home" selectedimage:@"tabbar_home_selected"];
    
    YJMessageViewController *Message = [[YJMessageViewController alloc]init];
    [self addChildVC:Message title:@"消息" image:@"tabbar_message_center" selectedimage:@"tabbar_message_center_selected"];
    
    YJDiscoverViewController *Discover = [[YJDiscoverViewController alloc]init];
    [self addChildVC:Discover title :@"发现" image:@"tabbar_discover" selectedimage:@"tabbar_discover_selected"];
    
    YJProfileViewController *Profile = [[YJProfileViewController alloc]init];
    [self addChildVC:Profile title:@"我" image:@"tabbar_profile" selectedimage:@"tabbar_profile_selected"];
    
    // 2. 更换系统自带的 tabbar
//    self.tabBar = [[YJTabBar alloc]init];
    YJTabBar *tabBar = [[YJTabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

// 有很多重复代码 ---> 讲重复代码抽取到一个方法中
// 1.不同的代码放到一个方法
// 2.不同的东西变成参数
// 3.在使用到这段代码的地方调用方法,传递参数

// 添加子控制器
-(void)addChildVC:(UIViewController *)ChildVC title:(NSString *)title image:(NSString *)image selectedimage:(NSString *)selectedimage
{
    // 设置子控制器的文字
//  ChildVC.navigationItem.title = title;
//  ChildVC.tabBarItem.title = title;
    ChildVC.title = title;
    
    // 设置子控制器的图片
    ChildVC.tabBarItem.image = [UIImage imageNamed:image];
    // 声明: 这张图片按照原始的样子显示出来,不要自动渲染其他颜色,比如 <蓝色>
    ChildVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = YJColor(123, 123, 123);
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [ChildVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [ChildVC.tabBarItem setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    
    // 先给传进来的控制器,包装一个导航控制器
    YJNavigationController *nav = [[YJNavigationController alloc]initWithRootViewController:ChildVC];
    // 再添加子控制器
    [self addChildViewController:nav];
}

#pragma mark YJTabBarDelegate代理方法
-(void)tabBarDidClickPlusButton:(YJTabBar *)tabBar
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor grayColor];
    [self presentViewController:vc animated:YES completion:^{
    }];
    
}
@end
