//
//  CustomBadge.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/5.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "CustomBadge.h"

#define BadgeViewFont [UIFont systemFontOfSize:11]

@implementation CustomBadge

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = BadgeViewFont;
        [self sizeToFit];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = BadgeViewFont;
    CGSize size = [badgeValue sizeWithAttributes:attrs];
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    } else {
        [self setImage:nil forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
    }
    
}

@end
