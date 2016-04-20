//
//  UITextView+Extension.m
//  YJHweibo
//
//  Created by YJH on 16/4/20.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
//- (void)insertAttributedText:(NSAttributedString *)text
//{
//    [self insertAttributedText:text settingBlock:nil];
//}

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接其他文字
    NSUInteger loc = self.selectedRange.location;
    // 该方法可以将文字或图片插入到指定位置! 利用selectedRange.location 光标在哪就插哪!
//    [attributedText insertAttributedString:text atIndex:loc];
    // 插入到选中的所有范围
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    // 调用外面传进来的代码
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
    self.attributedText = attributedText;
    
    // 移动光标到表情后面,即->让光标停留之前位置!
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
