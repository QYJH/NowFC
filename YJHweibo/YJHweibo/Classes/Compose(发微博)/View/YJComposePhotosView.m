//
//  YJComposePhotosView.m
//  YJHweibo
//
//  Created by YJH on 16/4/14.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJComposePhotosView.h"

@implementation YJComposePhotosView

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
    // 存储图片
    [self.photos addObject:image];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    // 一行的最大列数
    int maxColsPerRow = 4;
    
    // 每个图片之间的间距
    CGFloat margin = 10;
    
    // 每个图片的宽高
    CGFloat imageViewW = (self.width - (maxColsPerRow + 1) * margin) / maxColsPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 行号
        NSUInteger row = i / maxColsPerRow;
        // 列号
        NSUInteger col = i % maxColsPerRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.y = row * (imageViewH + margin);
        imageView.x = col * (imageViewW + margin) + margin;
    }
}

//- (NSArray *)images
//{
//    NSMutableArray *array = [NSMutableArray array];
//    for (UIImageView *imageView in self.subviews) {
//        [array addObject:imageView.image];
//    }
//    return array;
//}

@end
