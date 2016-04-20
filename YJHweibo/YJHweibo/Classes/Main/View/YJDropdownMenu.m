//
//  YJDropdownMenu.m
//  YJHweibo
//
//  Created by YJH on 16/3/28.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJDropdownMenu.h"
@interface YJDropdownMenu()
@property (nonatomic,weak) UIImageView *containerView;
@end
@implementation YJDropdownMenu

-(UIImageView *)containerView
{
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

+(instancetype)menu{

    return [[self alloc]init];
}

-(void)setContent:(UIView *)content
{
    _content = content;
    // 调整内容的位置
    content.x = 10;
    content.y = 15;
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];

}

-(void)setContentController:(UIViewController *)contentController{

    _contentController = contentController;
    
    self.content = contentController.view;
}
// 显示
-(void)showFrom:(UIView *)from{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 2.添加自己到窗口上
    [window addSubview:self];
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整灰色图片的位置
    // 默认情况下, frame 是以父控件左上角为坐标原点
    // 可以转换坐标系原点,改变 frame的参照点
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    // 通知外界,自己被显示了
    if ([self.deletege respondsToSelector:@selector(dropdownMenuDidshow:)]) {
        [self.deletege dropdownMenuDidshow:self];
    }
}
// 销毁
-(void)dismiss
{
    [self removeFromSuperview];
   // 通知外界,自己被销毁了
// 判断代理是否有该方法
    if ([self.deletege respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.deletege dropdownMenuDidDismiss:self];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}



@end
