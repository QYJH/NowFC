//
//  YJEmotionTextView.m
//  YJHweibo
//
//  Created by YJH on 16/4/20.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJEmotionTextView.h"
#import "YJEmotion.h"
#import "YJEmotionAttachment.h"
@implementation YJEmotionTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)insertEmotion:(YJEmotion *)emotion
{
    if (emotion.code) {
        // insertText : 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        // 创建附件 加载图片
        YJEmotionAttachment *attch = [[YJEmotionAttachment alloc]init];
        // 传递模型
        attch.emotion = emotion;
        
        CGFloat attchWH = self.font.lineHeight;
        // 图片大小等于文字行高
        attch.bounds = CGRectMake(0, - 4, attchWH, attchWH);
        
        // 根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        // 插入属性文字到光标位置
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            // 设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
}


- (NSString *)fullText{
    NSMutableString *fullText = [NSMutableString string];
    
    // 遍历所有的属性文字（图片、emoji、普通文字）
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        // 如果是图片表情
        YJEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) { // 图片
            [fullText appendString:attch.emotion.chs];
        } else { // emoji、普通文本
            // 获得这个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    
    return fullText;
}

//- (void)insertEmotion:(YJEmotion *)emotion
//{
//    if (emotion.code) {
//        // insertText将emoji表情插入到光标所在位置 (只能插入普通字符串)
//        [self insertText:emotion.code.emoji];
//    } else if(emotion.png){
//        // 创建附件 加载图片
//        UIImage *image = [UIImage imageNamed:emotion.png];
//        NSTextAttachment *attch = [[NSTextAttachment alloc]init];
//        attch.image = image;
//        
//        CGFloat attchWH = self.font.lineHeight;
//        // 图片大小等于文字行高
//        attch.bounds = CGRectMake(0, - 4, attchWH, attchWH);
//        
//        // 根据附件创建一个属性文字
//        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
//        
//        // 创建带有属性的文字
//        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
//        // 拼接 (保留) 之前的文字 (图片和普通文字)
//        [attributedText appendAttributedString:self.attributedText];
//        
//        // 拼接图片
//        // 必须在这 保留光标原来停留的位置
//        NSUInteger location = self.selectedRange.location;
//        //        [attributedText appendAttributedString:imageStr]; // 只能插入文字
//        // 较上面方法!  该方法可以将文字或图片插入到指定位置! 利用selectedRange.location 光标在哪就插哪!
//        [attributedText insertAttributedString:imageStr atIndex:location];
//        
//        // 设置带有属性文字(字体大小)
//        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
//        self.attributedText = attributedText;
//        
//        // 移动光标到表情后面,即->让光标停留之前位置!
//        self.selectedRange = NSMakeRange(location + 1, 0);
//    }
//}

// insertText将文字插入到光标所在位置
//    [self.textView insertText:emotion.chs];

/**
 selectedRange :
 1.本来是用来控制textView的文字选中范围
 2.如果selectedRange.length为0，selectedRange.location就是textView的光标位置
 
 关于textView文字的字体
 1.如果是普通文字（text），文字大小由textView.font控制
 2.如果是属性文字（attributedText），文字大小不受textView.font控制，应该利用NSMutableAttributedString的- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法设置字体
 **/

@end
