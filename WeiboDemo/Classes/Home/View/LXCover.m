//
//  LXCover.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/4.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXCover.h"

@implementation LXCover

+ (instancetype)show{
    LXCover *cover = [[LXCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    [GlobalKeyWindow addSubview:cover];
    
    return cover;
}

- (void)setDimBackground:(BOOL)dimBackground{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    } else {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(didClickCover:)]) {
        
        [_delegate didClickCover:self];
        
    }
    
}

@end
