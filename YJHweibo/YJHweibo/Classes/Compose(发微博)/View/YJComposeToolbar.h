//
//  YJComposeToolbar.h
//  YJHweibo
//
//  Created by YJH on 16/4/14.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    YJComposeToolbarButtonTypeCamera, // 照相机
    YJComposeToolbarButtonTypePicture, // 相册
    YJComposeToolbarButtonTypeMention, // 提到@
    YJComposeToolbarButtonTypeTrend, // 话题
    YJComposeToolbarButtonTypeEmotion // 表情
} YJComposeToolbarButtonType;

@class YJComposeToolbar;

@protocol YJComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(YJComposeToolbar *)toolbar didClickedButton:(YJComposeToolbarButtonType)buttonType;

@end

@interface YJComposeToolbar : UIView
@property (nonatomic, weak) id<YJComposeToolbarDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;
@end
