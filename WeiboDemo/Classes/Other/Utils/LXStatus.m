//
//  LXStatus.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXStatus.h"
#import "NSDate+MJ.h"

@implementation LXStatus

- (NSString *)created_at{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *createTime = [fmt dateFromString:_created_at];
    
    if ([createTime isThisYear]) {
        if ([createTime isToday]) {
            NSDateComponents *comp =  [createTime deltaWithNow];
            if (comp.hour) {
                return [NSString stringWithFormat:@"%ld小时前", comp.hour];
            } else if (comp.minute) {
                return [NSString stringWithFormat:@"%ld分钟前", comp.minute];
            } else {
                return @"刚刚";
            }
            
        } else if ([createTime isYesterday]){
            fmt.dateFormat = @"昨天 HH:mm";
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
        }
        
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    
    
    return [fmt stringFromDate:createTime];
}

- (void)setSource:(NSString *)source{
    if (![source isEqualToString:@""]) {
        NSRange range = [source rangeOfString:@">"];
        source = [source substringFromIndex:range.location + range.length];
        
        range = [source rangeOfString:@"</"];
        source = [source substringToIndex:range.location];
        _source = [NSString stringWithFormat:@"来自%@", source];
    }
}

@end
