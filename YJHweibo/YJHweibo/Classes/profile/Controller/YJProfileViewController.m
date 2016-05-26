//
//  YJProfileViewController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJProfileViewController.h"
#import "YJTextViewController.h"
#import "SDWebImageManager.h"
@interface YJProfileViewController ()

@end

@implementation YJProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获得缓存图片字节大小
    int byteSize = [SDImageCache sharedImageCache].getSize;
    // M大小
    double size = byteSize / 1000.0 / 1000.0;
    self.navigationItem.title = [NSString stringWithFormat:@"缓存大小(%.1fM)", size];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除缓存" style:0 target:self action:@selector(clearCache)];
    
    [self fileOperation];
}

// 删除沙盒Directory文件
- (void)fileOperation
{
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 缓存路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        YJLog(@"%@",caches);
    
    [mgr removeItemAtPath:caches error:nil];
    
    YJLog(@"%d", [@"/code/课程/微博/14/代码" fileSize]);
}

// 清除缓存
-(void)clearCache{
    // 提醒
    UIActivityIndicatorView *circle = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [circle startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:circle];
    
    // 清除图片缓存
    [[SDImageCache sharedImageCache] clearDisk];
    
    // 显示按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除缓存" style:0 target:self action:@selector(clearCache)];
    self.navigationItem.title = [NSString stringWithFormat:@"缓存大小(0M)"];
}


/**
 NSString *filepath = [caches stringByAppendingPathComponent:@"cn.heima.----2-/Cache.db-wal"];
 
 // 获得文件\文件夹的属性(注意:文件夹是没有大小属性的,只有文件才有大小属性)
 NSDictionary *attrs = [mgr attributesOfItemAtPath:filepath error:nil];
 HWLog(@"%@ %@", caches, attrs);
 */


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
