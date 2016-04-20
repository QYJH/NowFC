//
//  YJStatusCell.m
//  YJHweibo
//
//  Created by YJH on 16/4/13.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJStatusCell.h"
#import "YJStatus.h"
#import "YJStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "YJUser.h"
#import "YJPhoto.h"
#import "YJStatusToolbar.h"
#import "YJStatusPhotosView.h"
#import "YJIconView.h"

@interface YJStatusCell()
/** 原创微博整体 */
@property(nonatomic,weak) UIView *originaview;
/** 头像*/
@property(nonatomic,weak) YJIconView *iconView;
/** 会员图标*/
@property(nonatomic,weak) UIImageView *vipView;
/** 配图*/
@property(nonatomic,weak) YJStatusPhotosView *photosView;
/** 昵称*/
@property(nonatomic,weak) UILabel *nameLabel;
/** 时间*/
@property(nonatomic,weak) UILabel *timeLabel;
/** 来源*/
@property(nonatomic,weak) UILabel *sourceLabel;
/** 正文*/
@property(nonatomic,weak) UILabel *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) YJStatusPhotosView *retweetPhotosView;

/** 工具条 */
@property (nonatomic, weak) YJStatusToolbar *toolbar;

@end

@implementation YJStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    YJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YJStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置选中时的背景为蓝色
//        UIView *bg = [[UIView alloc] init];
//        bg.backgroundColor = [UIColor blueColor];
//        self.selectedBackgroundView = bg;
        
        
        // 初始化原创微博
        [self setupOriginal];
        
        // 初始化转发微博
        [self setupRetweet];

        // 初始化工具条
        [self setupToolbar];
    }
    return self;
}

//-(void)setFrame:(CGRect)frame
//{
//    frame.origin.y += YJStatusCellMargin;
//    
//    [super setFrame:frame];
//}


/**
 * 初始化工具条
 */
- (void)setupToolbar
{
    YJStatusToolbar *toolbar = [[YJStatusToolbar alloc]init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}


/**
 * 初始化转发微博
 */
- (void)setupRetweet{
    
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = YJStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    YJStatusPhotosView *retweetPhotosView = [[YJStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
    
}

    
/**
 * 初始化原创微博
 */
-(void)setupOriginal{
    // 原创微博整体
    UIView *originaview = [[UIView alloc]init];
    originaview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originaview];
    self.originaview = originaview;
    
    /** 头像*/
    YJIconView *iconView = [[YJIconView alloc]init];
    [originaview addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标*/
    UIImageView *vipView =[[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originaview addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图*/
    YJStatusPhotosView *photosView = [[YJStatusPhotosView alloc]init];
    [self.originaview addSubview:photosView];
    self.photosView = photosView;
    
    /** 昵称*/
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = YJStatusCellNameFont;
    [self.originaview addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间*/
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = [UIColor orangeColor];
//    [timeLabel sizeToFit];
    timeLabel.font = YJStatusCellTimeFont;
    [self.originaview addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来源*/
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = YJStatusCellSourceFont;
    [self.originaview addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文*/
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = YJStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [self.originaview addSubview:contentLabel];
    self.contentLabel = contentLabel;
}





-(void)setStatusFrame:(YJStatusFrame *)StatusFrame
{
    _StatusFrame = StatusFrame;
    
    YJStatus *status = StatusFrame.status;
    YJUser *user = status.user;
    
    // 原创微博整体
    /** 原创微博 view*/
    self.originaview.frame = StatusFrame.originalViewF;

    /** 头像*/
    self.iconView.frame = StatusFrame.iconViewF;
    self.iconView.user = user;
    
    /** 会员图标*/
    self.vipView.frame = StatusFrame.vipViewF;
    if (user.vip) {
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.nameLabel.textColor = [UIColor redColor];
        self.vipView.hidden = NO;
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosView.frame = StatusFrame.photosViewF;
#warning  设置图片
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    /** 昵称*/
    self.nameLabel.text = user.name;
    self.nameLabel.frame = StatusFrame.nameLabelF;
    
    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = StatusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(StatusFrame.nameLabelF) + YJStatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:YJStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + YJStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:YJStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    /** 正文*/
    self.contentLabel.text = status.text;
    self.contentLabel.frame = StatusFrame.contentLabelF;
    
    
    /** 被转发的微博 */
    if (status.retweeted_status) {
        YJStatus *retweeted_status = status.retweeted_status;
        YJUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        /** 被转发的微博整体 */
        self.retweetView.frame = StatusFrame.retweetViewF;
        
        /** 被转发的微博正文 */
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = StatusFrame.retweetContentLabelF;
        
        /** 被转发的微博配图 */
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = StatusFrame.retweetPhotosViewF;
            
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
    
    /** 工具条 */
    self.toolbar.frame = StatusFrame.toolbarF;
    self.toolbar.status = status;
}

@end
