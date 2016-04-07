//
//  YJMessageViewController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJMessageViewController.h"
#import "YJTextViewController.h"

@interface YJMessageViewController ()

@end

@implementation YJMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // style :是用来设置按钮背景图样式的, ios7后已经失效
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style: UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}


- (void)composeMsg {

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"text-Massage%ld",(long)indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJTextViewController *textVC = [[YJTextViewController alloc]init];
    textVC.title = @"测试";
    // 当textVC控制器push的时候,textVC所在的tabBarController中的TabBar会自动隐藏
    // 当textVC控制器pop的时候,textVC所在的tabBarController中的TabBar会自动弹出显示
//  textVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:textVC animated:YES];
   
}

@end
