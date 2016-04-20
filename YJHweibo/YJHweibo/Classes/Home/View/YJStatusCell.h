//
//  YJStatusCell.h
//  YJHweibo
//
//  Created by YJH on 16/4/13.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJStatusFrame;
@interface YJStatusCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) YJStatusFrame *StatusFrame;
@end
