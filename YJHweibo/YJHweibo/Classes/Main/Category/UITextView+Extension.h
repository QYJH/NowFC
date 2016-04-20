//
//  UITextView+Extension.h
//  YJHweibo
//
//  Created by YJH on 16/4/20.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
//- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;
@end
