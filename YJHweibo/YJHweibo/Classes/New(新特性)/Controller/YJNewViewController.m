//
//  YJNewViewController.m
//  YJHweibo
//
//  Created by YJH on 16/4/8.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJNewViewController.h"
#import "YJTabBarController.h"
#define NewfeatureCount 4
@interface YJNewViewController () <UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;
@end

@implementation YJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *ScrollView = [[UIScrollView alloc]init];
    ScrollView.frame = self.view.bounds;
    
    [self.view addSubview:ScrollView];
    
    CGFloat scrollW = ScrollView.width;
    CGFloat scrollH = ScrollView.height;
    for (int i = 0; i < NewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        [ScrollView addSubview:imageView];
        
        // 在最后个ImageView里增加子控件
        if (i == NewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    ScrollView.contentSize = CGSizeMake(NewfeatureCount * ScrollView.width, 0);
    ScrollView.delegate = self;
    ScrollView.bounces = NO; // 反弹
    ScrollView.pagingEnabled = YES; // 分页
    ScrollView.showsHorizontalScrollIndicator = NO; // 水平滚动条
    
    // UIPageControl 不设置宽高也能显示,但不能点击
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = NewfeatureCount; // 个数
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH- 50;
    pageControl.pageIndicatorTintColor = YJColor(189, 189, 189); // 默认
    pageControl.currentPageIndicatorTintColor = YJColor(253, 98, 42); // 选中
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}
// scrollView代理: 已经滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5); // 四舍五入
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset)); // 坐标
}
// 初始化最后一个imageView
-(void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互
    imageView.userInteractionEnabled = YES;
    
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 150;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);// x,z,s,y
//    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);// x,z,s,y
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    // 2. 开始微博
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

-(void)dealloc
{
    NSLog(@"dealloc ------   YJNewViewController");
}

-(void)shareClick:(UIButton *)shareBtn{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

-(void)startClick{
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
   window.rootViewController = [[YJTabBarController alloc]init];
}

@end
