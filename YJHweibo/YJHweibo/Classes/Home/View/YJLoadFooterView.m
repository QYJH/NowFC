 //
//  YJLoadFooterView.m
//  YJHweibo
//
//  Created by YJH on 16/4/12.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJLoadFooterView.h"
@interface YJLoadFooterView ()

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIActivityIndicatorView *Activity;
@end
@implementation YJLoadFooterView

+(instancetype)footer
{
    return [[self alloc]init];
    
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview];
    }
    return self;
}


-(UILabel *)label
{
    if(!_label){
    
        _label = [[UILabel alloc]init];
        _label.textAlignment = UITextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:16];
        _label.adjustsFontSizeToFitWidth = YES;
        _label.text = @"正在加载中...";
    }

    return _label;
}


-(UIActivityIndicatorView *)Activity{
    if (!_Activity) {
        _Activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_Activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [_Activity startAnimating];
        [_Activity setCenter:CGPointMake(self.label.frame.size.width / 2, self.label.frame.size.height / 2)];
    }
    return _Activity;
}

-(void)addSubview{
    [self addSubview:self.label];
    
    [self addSubview:self.Activity];
    
    [self layoutSubviews];
    
}
//-(void )layoutSubviews∫
//{
//    [super layoutSubviews];
//    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.height.equalTo(@35);
//        make.centerX.equalTo (self.mas_centerX);
//    }];
//    
//    [self.Activity mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.label.mas_right);
//        make.top.equalTo(self.label.mas_top).offset(5);
//    }];
//    
//}
@end
