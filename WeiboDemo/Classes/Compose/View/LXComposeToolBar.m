//
//  LXComposeToolBar.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/11.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXComposeToolBar.h"

@implementation LXComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildChildViews];
    }
    return self;
}

- (void)buildChildViews{
    
    [self createButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highlightImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(buttonDidClick:)];
    
    [self createButtonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highlightImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(buttonDidClick:)];
    
    [self createButtonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highlightImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(buttonDidClick:)];
    
    [self createButtonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highlightImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(buttonDidClick:)];
    
     [self createButtonWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highlightImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(buttonDidClick:)];
}

- (void)createButtonWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = self.subviews.count;
    
    [self addSubview:button];
    
}

- (void)buttonDidClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickButton:)]) {
        [self.delegate composeToolBar:self didClickButton:button.tag];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *button = self.subviews[i];
        x = i * w;
        button.frame = CGRectMake(x, y, w, h);
    }
}

@end
