//
//  YJHomeViewController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.


//  App Key：3346461650
//  App Secret：4a569d4cab9053d194429604dc524d19

#import "YJHomeViewController.h"
#import "YJDropdownMenu.h"
#import "YJTitleMenuViewController.h"
@interface YJHomeViewController () <YJDropdownMenuDeletege>

@end

@implementation YJHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 直接调用 UIBarButtonItem分类 里的类方法
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    // 直接调用 UIBarButtonItem分类 里的类方法
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.width = 150;
    titleButton.height = 30;
    [titleButton setTitle:@"首页" forState: UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.width = 130;
    btn.height = 30;
    btn.x = 70;
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
}


-(void)titleClick:(UIButton *)titleButton{
    // 1.创建下拉菜单
    YJDropdownMenu *menu = [YJDropdownMenu menu];
    
    menu.deletege = self;
    
    // 2.设置内容
    YJTitleMenuViewController *vc = [[YJTitleMenuViewController alloc]init];
//    menu.content = [[UITableView alloc]init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;
    // 3.显示
    [menu showFrom:titleButton];
    
}

-(void)friendsearch{


}

-(void)pop{


}

#pragma mark YJDropdownMenuDeletege
// 下拉菜单被销毁
-(void)dropdownMenuDidDismiss:(YJDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向下
    titleButton.selected = NO;
}
// 下拉菜单被显示
-(void)dropdownMenuDidshow:(YJDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向上
    titleButton.selected = YES;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


@end
