//
//  YJTitleButton.m
//  YJHweibo
//
//  Created by YJH on 16/4/9.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJTitleButton.h"

@implementation YJTitleButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
  if(self)
  {
      // 内容居中
//      self.imageView.contentMode = UIViewContentModeCenter;
//      self.backgroundColor = [UIColor yellowColor];
      [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      self.titleLabel.font = [UIFont systemFontOfSize:15];
      [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
      [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
  }
    return self;
}

// 在系统计算和设置完按钮的尺寸后,再修改一下尺寸
-(void)setFrame:(CGRect)frame
{
    frame.size.width += 10;
    
    [super setFrame: frame];
    
    YJLog(@"--- %@",NSStringFromCGRect(frame));

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算titleLabel的 frame
//    self.titleLabel.x = self.imageView.x;
    // 计算imageView的 frame

// 如果只是想调整按钮,文字或图片的位置,那么在layoutSubviews中单独设置位置即可
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

#pragma mark 去除按钮高亮状态
-(void)setHighlighted:(BOOL)highlighted
{
    NSLog(@"%s",__func__);
}


//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//
//    return  CGRectMake(0, 0, 0, 0);
//}
//
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//
//    return  CGRectMake(0, 0, 0, 0);
//}
@end
