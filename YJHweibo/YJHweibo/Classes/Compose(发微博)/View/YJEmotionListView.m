//
//  YJEmotionListView.m
//  YJYJeibo
//
//  Created by YJH on 16/4/18.
//  Copyright © 2016年 YJH. All rights reserved.
//
#import "YJEmotionListView.h"
#import "YJEmotionPageView.h"


@interface YJEmotionListView() <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation YJEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 1.UIScollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];

        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        // 去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        // 去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        // 当只有一页时自动隐藏 pageControl
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        
        // 设置内部的圆点图片  利用 KVC
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

// 根据emotions，创建对应个数的表情
- (void)setEmotions:(NSArray *)emotions{
    YJLog(@"表情数量 = %ld",(unsigned long)emotions.count);
    _emotions = emotions;
    
#warning 点击表情按钮进入这里让 (<最近>的recentListView) 重新计算==刷新!
    // 删除之前的控件,
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    YJLog(@"count =   %ld",(unsigned long)self.scrollView.subviews.count);
    
    NSUInteger count = (emotions.count + YJEmotionPageSize - 1) / YJEmotionPageSize;
    // 1.设置页数
    self.pageControl.numberOfPages = count;
    
    // 2.创建用来显示每一页表情的控件
    for (int i = 0; i < count; i++) {
        YJEmotionPageView *pageView = [[YJEmotionPageView alloc] init];
        
        NSRange range;
        range.location = i * YJEmotionPageSize;
        // left：剩余的表情个数（可以截取的）
        NSUInteger left = emotions.count - range.location;
        if (left >= YJEmotionPageSize) { // 这一页足够20个
            range.length = YJEmotionPageSize;
        } else {
            range.length = left;
        }
        
        // 设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        
        [self.scrollView addSubview:pageView];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        UIView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    // 4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (NSUInteger)(pageNo + 0.5);
}
@end
