//
//  YJStatusFrame.h
//  YJHweibo
//
//  Created by YJH on 16/4/13.
//  Copyright © 2016年 YJH. All rights reserved.
// 一个 YJStatusFrame模型里面的内容,存放着一个 cell内部所有子控件的 frame
// 存放着一个数据模型 YJStatus
#import <Foundation/Foundation.h>

// 昵称字体
#define YJStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define YJStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define YJStatusCellSourceFont YJStatusCellTimeFont
// 正文字体
#define YJStatusCellContentFont [UIFont systemFontOfSize:14]

// 被转发微博的正文字体
#define YJStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

// cell的边框宽度
#define YJStatusCellBorderW 10

// cell之间的间距
#define YJStatusCellMargin 15

@class YJStatus;
@interface YJStatusFrame : NSObject
@property(nonatomic,strong) YJStatus *status;

/** 原创微博 view*/
@property(nonatomic,assign) CGRect originalViewF;
/** 头像*/
@property(nonatomic,assign) CGRect iconViewF;
/** 会员图标*/
@property(nonatomic,assign) CGRect vipViewF;
/** 配图*/
@property(nonatomic,assign) CGRect photosViewF;
/** 昵称*/
@property(nonatomic,assign) CGRect nameLabelF;
/** 时间*/
@property(nonatomic,assign) CGRect timeLabelF;
/** 来源*/
@property(nonatomic,assign) CGRect sourceLabelF;
/** 正文*/
@property(nonatomic,assign) CGRect contentLabelF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotosViewF;

/** 底部工具条 */
@property (nonatomic, assign) CGRect toolbarF;
/** cell 的高度*/
@property(nonatomic,assign) CGFloat cellHeight;
@end
