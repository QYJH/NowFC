//
//  YJDropdownMenu.h
//  YJHweibo
//
//  Created by YJH on 16/3/28.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJDropdownMenu;
@protocol YJDropdownMenuDeletege <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(YJDropdownMenu *)menu;
- (void)dropdownMenuDidshow:(YJDropdownMenu *)menu;
@end

@interface YJDropdownMenu : UIView

@property(nonatomic,weak) id<YJDropdownMenuDeletege> deletege;

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
