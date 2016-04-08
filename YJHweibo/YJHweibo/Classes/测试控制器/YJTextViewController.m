//
//  YJTextViewController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJTextViewController.h"
#import "YJTextTwoViewController.h"
@interface YJTextViewController ()

@end

@implementation YJTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJRandomColor;
    
//    // 设置返回按钮图片,文字
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    // 设置尺寸
//    backBtn.size = backBtn.currentBackgroundImage.size;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    
//    // 设置返回按钮图片,文字
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
//    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
//    // 设置尺寸
//    moreBtn.size = moreBtn.currentBackgroundImage.size;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
}

//-(void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//-(void)more
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YJTextTwoViewController *twoVC = [[YJTextTwoViewController alloc]init];
    twoVC.title = @"测试Two";
    [self.navigationController pushViewController:twoVC animated:YES];
}

@end
