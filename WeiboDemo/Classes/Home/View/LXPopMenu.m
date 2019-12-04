//
//  LXPopMenu.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/4.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXPopMenu.h"

@implementation LXPopMenu

+ (instancetype)showInRect:(CGRect)rect{
    LXPopMenu *menu = [[LXPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [GlobalKeyWindow addSubview:menu];
    
    return menu;
}

+ (void)hide{
    for (UIView *view in GlobalKeyWindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
}

- (void)setContentView:(UIView *)contentView{
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    CGFloat y = 9;
    CGFloat x = 0;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
}

@end
