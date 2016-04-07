//
//  UIBarButtonItem+Extension.h
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
