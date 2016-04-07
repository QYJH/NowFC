//
//  YJDropdownMenu.h
//  YJHweibo
//
//  Created by YJH on 16/3/28.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJDropdownMenu : UIView
+(instancetype) menu;
// 显示
-(void)showFrom:(UIView *)from;
// 销毁
-(void)dismiss;
// 内容
@property(nonatomic,strong)UIView *content;
// 内容控制器
@property(nonatomic,strong) UIViewController *contentController;
@end
