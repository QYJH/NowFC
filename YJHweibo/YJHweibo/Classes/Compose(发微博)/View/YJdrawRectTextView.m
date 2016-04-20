//
//  YJdrawRectTextView.m
//  YJHweibo
//
//  Created by YJH on 16/4/17.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJdrawRectTextView.h"

@implementation YJdrawRectTextView
-(id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        // 当UITextView发生文字改变时 UITextView会发出 UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
-(void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    
    [self setNeedsDisplay];
}

-(void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    
    [self setNeedsDisplay];
}
// 调用text时清空占位文字
-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}
// 调用attributedText时清空占位文字
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

// 监听文字改变
-(void)textDidChange{

     // 重绘 (重新调用) drawRect
    [self setNeedsDisplay];

}

-(void)drawRect:(CGRect)rect
{
    // 如果有文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attrs  = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 画文字
//    [self.placehoder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    
    CGRect placeholderRect = CGRectMake(5, 6, rect.size.width - 10, rect.size.height - 16);
    [self.placehoder drawInRect:placeholderRect withAttributes:attrs];
}
@end
