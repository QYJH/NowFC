//
//  YJStatusFrame.m
//  YJHweibo
//
//  Created by YJH on 16/4/13.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJStatusFrame.h"
#import "YJStatus.h"
#import "YJUser.h"
#import "YJStatusPhotosView.h"
// cell的边框宽度
#define YJStatusCellBorderW 10

@implementation YJStatusFrame



-(void)setStatus:(YJStatus *)status
{
    _status = status;
    YJUser *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;

    /** 头像*/
    CGFloat iconWH = 50;
    CGFloat iconX = YJStatusCellBorderW;
    CGFloat iconY = YJStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + YJStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:YJStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** 会员图标*/
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + YJStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW ,vipH);
    }

    /** 时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + YJStatusCellBorderW;
    CGSize  timeSize = [status.created_at sizeWithFont:YJStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /** 来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + YJStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [status.source sizeWithFont:YJStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    /** 正文*/
    CGFloat contenX = iconX;
    // 取头像或时间的最大数
    CGFloat contenY = MAX(CGRectGetMaxY(self.iconViewF),CGRectGetMaxY(self.timeLabelF)) + YJStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contenX;
    // 计算文字大小
    CGSize  contenSize = [status.attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentLabelF = (CGRect){{contenX,contenY},contenSize};
    
    
    /** 配图*/
    CGFloat originalH = 0;
    if (status.pic_urls.count) { // 有配图
        CGFloat photoX = iconX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + YJStatusCellBorderW;
        CGSize photosSize = [YJStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photoX,photoY},photosSize},
        
        originalH = CGRectGetMaxY(self.photosViewF) + YJStatusCellBorderW;
    } else { // 没配图
        originalH = CGRectGetMaxY(self.contentLabelF) + YJStatusCellBorderW;
    }
    
    
    /** 原创微博 整体*/
    CGFloat originalX = 0;
    CGFloat originalY = YJStatusCellMargin;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat toolbarY = 0;
    /* 被转发微博 */
    if (status.retweeted_status) {
        YJStatus *retweeted_status = status.retweeted_status;
        
        /** 被转发微博正文 */
        CGFloat retweetContentX = YJStatusCellBorderW;
        CGFloat retweetContentY = YJStatusCellBorderW;
        CGSize retweetContentSize = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelF) + YJStatusCellBorderW;

            CGSize retweetPhotosSize = [YJStatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotosX,retweetPhotosY},retweetPhotosSize};
            
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + YJStatusCellBorderW;
        } else { // 转发微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + YJStatusCellBorderW;
        }
        
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
        /** 工具条 */
        CGFloat toolbarX = 0;
        CGFloat toolbarW = cellW;
        CGFloat toolbarH = 35;
        self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        
        /* cell的高度 */
        self.cellHeight = CGRectGetMaxY(self.toolbarF);
}
@end
