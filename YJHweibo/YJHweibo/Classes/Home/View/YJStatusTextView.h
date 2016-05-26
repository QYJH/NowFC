//
//  YJStatusTextView.h
//  YJHweibo
//
//  Created by YJH on 16/4/26.
//  Copyright © 2016年 YJH. All rights reserved.
//  用来显示微博正文的textView

#import <UIKit/UIKit.h>

@interface YJStatusTextView : UITextView
/** 所有的特殊字符串(里面存放着YJSpecial) */
@property (nonatomic, strong) NSArray *specials;
@end
