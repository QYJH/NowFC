//
//  YJStatus.m
//  YJHweibo
//
//  Created by YJH on 16/4/11.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "YJStatus.h"
#import "YJPhoto.h"
#import "MJExtension.h"
@implementation YJStatus

- (NSDictionary *)objectClassInArray
{
    // pic_urls数组中,放着 YJPhoto 模型
    return @{@"pic_urls" : [YJPhoto class]};
}


- (NSString *)created_at
{
    // NSDateFormatter就相当于是NSDate的转换类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([self isThisYear:createDate]) { // 今年
        if ([self isYesterday:createDate]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([self isToday:createDate]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}




/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday:(NSDate *)date
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 日期格式
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:date];
    
    NSString *nowStr = [fmt stringFromDate:now];
    // 微博时间
    date = [fmt dateFromString:dateStr];
    // 当前时间
    now = [fmt dateFromString:nowStr];
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday:(NSDate *)date
{
    NSDate *now = [NSDate date];
    // NSDateFormatter就相当于是NSDate的转换类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 日期格式
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

//- (void)setSource:(NSString *)source
//{
//    // 截串 NSString
//    NSRange range;
//    range.location = [source rangeOfString:@">"].location + 1;
//    range.length = [source rangeOfString:@"</"].location - range.location;
//    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
//    NSLog(@"source= %@",_source);
//}

//+(instancetype)statusWintDict:(NSDictionary *)dict
//{
//    YJStatus *status = [[YJStatus alloc]init];
//    status.idstr = dict[@"idstr"];
//    status.text = dict[@"text"];
//    status.user = [YJUser UserWithDict:dict[@"user"]];
//    return status;
//}
@end
