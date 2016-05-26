//
//  YJHomeViewController.m
//  YJHweibo
//
//  Created by YJH on 16/3/23.
//  Copyright © 2016年 YJH. All rights reserved.

#import "YJHomeViewController.h" 
#import "YJDropdownMenu.h"
#import "YJTitleMenuViewController.h"
#import "YJAccountTool.h"
#import "YJTitleButton.h"
#import "UIImageView+WebCache.h"
#import "YJUser.h"
#import "YJStatus.h"
#import "MJExtension.h"
#import "YJLoadFooterView.h"
#import "YJStatusCell.h"
#import "YJStatusFrame.h"
#import "YJHttpTool.h"
#import "MJRefresh.h"
#import "YJStatusTool.h"

@interface YJHomeViewController () <YJDropdownMenuDeletege>
@property (nonatomic,strong) NSMutableArray *statusFrames; // 微博数组
@end

@implementation YJHomeViewController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YJColor(211, 211, 211);
//    self.tableView.contentInset = UIEdgeInsetsMake(YJStatusCellMargin, 0, 0, 0);
    
    // 设置导航栏内容
    [self setupNav];
    
    // 获得用户信息(昵称)
    [self setupUserInfo];
    
    // 加载最新微博数据
//    [self loadNewStatus2];
    
    // 集成下拉刷新控件
    [self setupDownRefresh];
    
    // 集成上拉刷新控件
    [self setupUpRefresh];
    
    // 获取未读数量
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setuoUnreadCount) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

// 定时获取未读数量
-(void)setuoUnreadCount
{
    NSString *url = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    YJAccount *account = [YJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        int status = [[responseObject objectForKey:@"status"]intValue];
//        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",status];
        // NSNumber 转成字符串 用description
        // 设置提醒数 (微博的未读数)
       NSString *status = [[responseObject objectForKey:@"status"]description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


// 集成上拉刷新控件
-(void)setupUpRefresh{
//    YJLoadFooterView *footer = [YJLoadFooterView footer];
//    // 隐藏footer
//    footer.hidden = YES;
//    self.tableView.tableFooterView = footer;
    
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];

}

// 集成下拉刷新控件
-(void)setupDownRefresh{
//    // 1. 添加刷新控件
//    UIRefreshControl *control = [[UIRefreshControl alloc]init];
//    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:control];
//    
//    // 2. 马上进入刷新状态(仅仅是显示刷新状态,并不会调用刷新事件)
//    [control beginRefreshing];
//    
//    // 3.马上加载数据
//    [self loadNewStatus:control];
    
    // 1.添加刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 2.进入刷新状态
    [self.tableView headerBeginRefreshing];
}

#pragma mark 刷新控件触发事件 下拉刷新
-(void)loadNewStatus{
    YJAccount *account = [YJAccountTool account];
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    // 取出最前面的微博
    YJStatusFrame *firstStatusF = [self.statusFrames firstObject];
    
    if (firstStatusF) {
//  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    params[@"since_id"] = firstStatusF.status.idstr;
}
    // 1. 定义一个block处理返回的字典数据
    void (^dealingResult)(NSArray *) = ^(NSArray *statuses){
    // 将 "微博字典"数组 转为 "微博模型"数组
    NSArray *newStatuses = [YJStatus objectArrayWithKeyValuesArray:statuses];
    
    // 将YJStatus数组 转为 statusFramees数组
    NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
    
    // 将最新数据数组加到-->总数组最前面
    NSRange range = NSMakeRange(0, newFrames.count);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.statusFrames insertObjects:newFrames atIndexes:set];
    // 刷新表格
    [self.tableView reloadData];
    // 结束刷新
    //        [control endRefreshing];
    [self.tableView headerEndRefreshing];
    // 显示加载到最新微博数量
    [self showNewStatusCount:newStatuses.count];
 };
    
    //  2. 先尝试从数据库中加载微博数据
    NSArray *statuses = [YJStatusTool statusesWithParams:params];
    if (statuses.count) {
        dealingResult(statuses);
    }else{
   //   3. 发送请求
        [YJHttpTool get:url params:params success:^(id json) {
            YJLog(@"responseObject =%@",json);
            
            [YJStatusTool saveStatuses:json[@"statuses"]];
            // 刷新数据
            dealingResult(json[@"statuses"]);
        } failure:^(NSError *error) {
            YJLog(@"error =%@",error);
            
            // 结束刷新
            [self.tableView headerEndRefreshing];
        }];
  }
}
#pragma mark 显示加载到最新微博数量
-(void)showNewStatusCount:(NSUInteger)count
{  // 刷新成功 (清楚图标数字)
    self.tabBarItem.badgeValue = nil;
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.y = 64 - label.height;
    if (count == 0) {
        label.text  = @"没有新的微博数据，稍后再试";
    }else{
        label.text  = [NSString stringWithFormat:@"共有%d条最新微博",count];
    }
    // 将label添加到导航控制器的 view 中,并且是在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
//        label.y += label.height ;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) { // 执行完动画后再次执行动画
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        label.y -= label.height;
        label.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
 }];

}

#pragma mark 加载最新微博数据
-(void)loadNewStatus2{
    YJAccount *account = [YJAccountTool account];
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"count"] = @20;
    AFHTTPRequestOperationManager *mager = [AFHTTPRequestOperationManager manager];
    [mager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        YJLog(@"responseObject =%@",responseObject);
//        // 取得微博数组
//        NSArray *dictArray = [responseObject objectForKey:@"statuses"];
//        // 将数组转成字典-->再转成模型
//        for (NSDictionary *dict in dictArray) {
//            YJStatus *status = [YJStatus statusWintDict:dict];
//            [self.statuses addObject:status];
//        }
        
         // 将数组转成字典-->再转成模型
        NSArray *newstatus = [YJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        // 将YJStatus数组 转为 statusFramees数组
        NSArray *newFrames = [self stausFramesWithStatuses:newstatus];
        // 将最新数据加到-->总数组最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"error =%@",error);
    }];
}

#pragma mark 设置导航栏内容
-(void)setupNav
{
    // 直接调用 UIBarButtonItem分类 里的类方法
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    // 直接调用 UIBarButtonItem分类 里的类方法
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    YJTitleButton *titleButton = [[YJTitleButton alloc]init];
    NSString *name = [YJAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState: UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];// 粗体
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

#pragma mark 获得用户信息(昵称)
-(void)setupUserInfo{
    YJAccount *account = [YJAccountTool account];
        NSString *url = @"https://api.weibo.com/2/users/show.json";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = account.access_token;
        params[@"uid"] = account.uid;
        
    [YJHttpTool get:url params:params success:^(id json){
                
        YJUser *user = [YJUser objectWithKeyValues:json];
        NSLog(@"%@",user);
        // 标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
         [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        account.name = user.name;
        [YJAccountTool saveAccount:account];
    }failure:^(NSError *error){
        
  }];
}

#pragma mark 昵称按钮点击
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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获得 cell
    YJStatusCell *cell = [YJStatusCell cellWithTableView:tableView];
    
    cell.StatusFrame = self.statusFrames[indexPath.row];

    return cell;
}

// cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // scrollView == self.tableView == self.view
//    // 如果tableView还没有数据，就直接返回
//    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
//    
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    // 当最后一个cell完全显示在眼前时，contentOffset的y值
//    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
//    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
//        // 显示footer
//        self.tableView.tableFooterView.hidden = NO;
//        
//        // 加载更多的微博数据
//        [self loadMoreStatus];
//    }
//    /*
//     contentInset：除具体内容以外的边框尺寸
//     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
//     contentOffset:
//     1.它可以用来判断scrollView滚动到什么位置
//     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
//     */
//}

/**
 *  加载更多的微博数据
 */
-(void)loadMoreStatus{
    // 拼接请求参数
    YJAccount *account = [YJAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    YJStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    // 处理字典数据
    void (^dealingResult)(NSArray *) = ^(NSArray *statuses) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [YJStatus objectArrayWithKeyValuesArray:statuses];
        // 将 YJStatus数组 转为 YJStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        [self.tableView footerEndRefreshing];
    };
    // 3.发送请求
    [YJHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        // 缓存新浪返回的字典数组
        [YJStatusTool saveStatuses:json[@"statuses"]];
        // 刷新数据
        dealingResult(json[@"statuses"]);
    } failure:^(NSError *error) {
        YJLog(@"请求失败-%@", error);
        
        // 结束刷新(隐藏footer)
        [self.tableView footerEndRefreshing];
    }];
}

// 将YJStatus模型 转为 YJStatusFrame模型
-(NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (YJStatus *status in statuses) {
        YJStatusFrame *Frame = [[YJStatusFrame alloc]init];
        Frame.status = status;
        [frames addObject:Frame];
    }
    return frames;
}

#pragma mark - 刷新
- (void)refresh:(BOOL)fromSelf
{
    if (self.tabBarItem.badgeValue) { // 有数字
        //进入刷新状态
        [self.tableView headerBeginRefreshing];
        
        [self loadNewStatus];
    }else if (fromSelf){ // 没有数字
        // 让表格回到最顶部
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
@end
