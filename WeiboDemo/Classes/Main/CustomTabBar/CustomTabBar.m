//
//  CustomTabBar.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/5.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "CustomTabBar.h"
#import "CustomTabBarButton.h"

@interface CustomTabBar()

@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation CustomTabBar

- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        _buttons = mutableArray;
    }
    
    return _buttons;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    
    for (UITabBarItem *item in _items) {
        CustomTabBarButton *tabBarButton = [CustomTabBarButton buttonWithType:UIButtonTypeCustom];
        tabBarButton.item = item;
        tabBarButton.tag = self.buttons.count;
        [tabBarButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        
        if (tabBarButton.tag == 0) {
            [self buttonClick:tabBarButton];
        }
        
        [self addSubview:tabBarButton];
        [self.buttons addObject:tabBarButton];
    }
}

- (void)buttonClick:(UIButton *)button{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

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
    for (UIView *tabBarButton in self.buttons) {
        
        if (i == 2) {
            i++;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    
    self.plusButton.center = CGPointMake(tabBarW/2, tabBarH/2);
    
}

@end
