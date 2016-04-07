//
//  YJDiscoverViewController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJDiscoverViewController.h"
#import "YJSearchBar.h"

@interface YJDiscoverViewController () <UITextFieldDelegate>

@end

@implementation YJDiscoverViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    YJSearchBar *SearchBar = [YJSearchBar searchBar];
    SearchBar.width = self.view.width;
    SearchBar.height = 30;
    self.navigationItem.titleView = SearchBar;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// 点击return退出键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
