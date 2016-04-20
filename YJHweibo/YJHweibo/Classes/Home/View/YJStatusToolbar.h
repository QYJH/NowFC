//
//  YJStatusToolbar.h
//  YJHweibo
//
//  Created by YJH on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJStatus;
@interface YJStatusToolbar : UIView
+ (instancetype)toolbar;
@property (nonatomic, strong) YJStatus *status;
@end
