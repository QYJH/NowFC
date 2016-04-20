//
//  YJIconView.m
//  YJHweibo
//
//  Created by YJH on 16/4/17.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJIconView.h"
#import "YJUser.h"
#import "UIImageView+WebCache.h"
@interface YJIconView()

@property(nonatomic,weak)UIImageView *verifiedView;

@end

@implementation YJIconView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 25;
        self.clipsToBounds = YES;
    }
    return self;
}
// 加 V 图标
-(UIImageView *)verifiedView{

    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc]init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

-(void)setUser:(YJUser *)user
{
    _user = user;
    // 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_/default_small"]];
    
    // 2.设置加 V 图片
    switch (user.verified_type) {
        case YJUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case YJUserVerifiedOrgEnterprice:
        case YJUserVerifiedOrgMedia:
        case YJUserVerifiedOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
            case YJUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES; // 当做没有任何认证
            break;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
//    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width - 5;
    self.verifiedView.y = self.height - self.verifiedView.height - 2;
    
//    self.verifiedView.width = 15;
//    self.verifiedView.height = 15;
//    self.verifiedView.x = 10;
//    self.verifiedView.y = 10;
}
@end
