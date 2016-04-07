//
//  YJNavigationController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJNavigationController.h"

@interface YJNavigationController ()

@end

@implementation YJNavigationController
// 类第一次使用的时候会调用一次 (初始化)
+ (void)initialize
{
    // 设置整个项目所有 item 的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态 颜色 字体
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态 颜色 字体
    NSMutableDictionary *disabledtextAttrs = [NSMutableDictionary dictionary];
    disabledtextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disabledtextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:disabledtextAttrs forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

/* 重写这个方法的目的,拦截所有push进来的控制器,设置内容
   viewController = 即将push进来的控制器 */
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0){ // 如果这时 push 进来的不是根控制器
//        // 自动显示和隐藏TabBar
//        viewController.hidesBottomBarWhenPushed = YES;
//        // 设置左边返回按钮
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
//        // 设置右边按钮
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
//    }
//    [super pushViewController:viewController animated:YES];
//}
//
//-(void)back
//{
//#warning 这里不能使用self.NavigationController这里是nil的,因为 self本身就是NavigationController
//    [self popViewControllerAnimated:YES];
//}
//-(void)more
//{
//#warning 这里不能使用self.NavigationController这里是nil的,因为 self本身就是NavigationController
//    [self popToRootViewControllerAnimated:YES];
//}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
