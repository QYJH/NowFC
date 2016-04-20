//
//  YJComposePhotosView.h
//  YJHweibo
//
//  Created by YJH on 16/4/14.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJComposePhotosView : UIView
/**
 *  添加一张图片到相册内部
 *
 *  @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image;
@property (nonatomic, strong, readonly) NSMutableArray *photos;
//- (NSArray *)images;
@end
