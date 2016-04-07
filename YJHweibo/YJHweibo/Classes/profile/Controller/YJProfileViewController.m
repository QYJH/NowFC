//
//  YJProfileViewController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJProfileViewController.h"
#import "YJTextViewController.h"
@interface YJProfileViewController ()

@end

@implementation YJProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style: UIBarButtonItemStyleDone target:self action:@selector(back)];
}


-(void)back{
    YJTextViewController *text = [[YJTextViewController alloc]init];
    text.title = @"测试一";
    [self.navigationController pushViewController:text animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
