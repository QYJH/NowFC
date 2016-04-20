//
//  YJStatusPhotosView.m
//  YJHweibo
//
//  Created by YJH on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJStatusPhotosView.h"
#import "YJPhoto.h"
#import "YJStatusPhotoView.h"

#define YJStatusPhotoWH 70
#define YJStatusPhotoMargin 10
#define YJStatusPhotoMaxCol(count) ((count==4)?2:3)
@implementation YJStatusPhotosView

- (id)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
    
    }
    return self;
}


-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;

    NSUInteger photosCount = photos.count;

    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        YJStatusPhotoView *photoView = [[YJStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        YJStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }

    
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = YJStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        YJStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (YJStatusPhotoWH + YJStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (YJStatusPhotoWH + YJStatusPhotoMargin);
        photoView.width = YJStatusPhotoWH;
        photoView.height = YJStatusPhotoWH;
    }
}


+(CGSize)sizeWithCount:(NSUInteger)count{
    
    // 最大列数 (每一行有多少列)
    NSUInteger maxCols = YJStatusPhotoMaxCol(count);
    // 列数
    // 如果 count >= 3 cols就是3列 否则就是其他
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * YJStatusPhotoWH + (cols - 1) * YJStatusPhotoMargin;
    
    // 行数    count图片数量
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    NSLog(@"%ld",rows);
    CGFloat photosH = rows * YJStatusPhotoWH + (rows - 1) * YJStatusPhotoMargin;
    
    return  CGSizeMake(photosW, photosH);
}
@end
