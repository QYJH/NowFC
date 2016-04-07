//
//  YJSearchBar.m
//  YJHweibo
//
//  Created by YJH on 16/3/24.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJSearchBar.h"

@implementation YJSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"输入您想搜索的内容";
        self.keyboardType  = UIKeyboardTypeDefault;
        
        // 通过initWithImage来创建初始化UIImageView , UIImageView的尺寸默认就等于image的尺寸
        // 通过init来创建初始化绝大部分控制,控件都是没有尺寸的
        UIImage *image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        UIImageView *SearchIcon = [[UIImageView alloc]initWithImage:image];
        SearchIcon.width = 30;
        SearchIcon.height = 30;
        SearchIcon.contentMode = UIViewContentModeCenter; // 文字居中
        
        self.leftView = SearchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;// 显示模式
    }
    return self;
}
+(instancetype)searchBar{

    return [[self alloc]init];
}
@end
