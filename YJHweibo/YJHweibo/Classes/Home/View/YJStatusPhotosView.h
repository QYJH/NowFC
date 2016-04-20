//
//  YJStatusPhotosView.h
//  YJHweibo
//
//  Created by YJH on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
// cell上面的配图相册（里面会显示1~9张图片

#import <UIKit/UIKit.h>

@interface YJStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片个数计算相册的尺寸
 */
+ (CGSize)sizeWithCount:(NSUInteger)count;

@end
