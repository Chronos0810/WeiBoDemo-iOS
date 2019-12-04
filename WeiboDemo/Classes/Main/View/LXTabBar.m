//
//  LXTabBar.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/4.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXTabBar.h"

@interface LXTabBar()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation LXTabBar

- (UIButton *)plusButton{
    if (_plusButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        
        _plusButton = button;
        [self addSubview:_plusButton];
    }
    
    return _plusButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat tabBarW = self.bounds.size.width;
    CGFloat tabBarH = self.bounds.size.height;
    if (@available(iOS 11.0, *)) {
        tabBarH = tabBarH - self.safeAreaInsets.bottom;
    }
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = tabBarW / (self.items.count + 1);
    CGFloat btnH = tabBarH;
    
    
    int i = 0;
    for (UIView *tabBarButton in self.subviews) {
        
        if (i == 2) {
            i++;
        }
        btnX = i * btnW;
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
    
    self.plusButton.center = CGPointMake(tabBarW/2, tabBarH/2);
    
}

@end
