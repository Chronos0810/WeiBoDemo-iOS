//
//  LXStatusToolBar.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXStatusToolBar.h"

@interface LXStatusToolBar()

@property (nonatomic, strong) NSMutableArray *buttonList;

@end

@implementation LXStatusToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initChildView];
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
    }
    return self;
}

- (NSMutableArray *)buttonList{
    if (_buttonList == nil) {
        _buttonList = [NSMutableArray array];
    }
    
    return _buttonList;
}

- (void)initChildView{
    
    UIButton *retweet = [self buttonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    UIButton *comment = [self buttonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    UIButton *unlike = [self buttonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    
}

- (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:button];
    
    [self.buttonList addObject:button];
    
    return button;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.buttonList.count;
    CGFloat w = ScreenW / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < count; i++) {
        UIButton *button = self.buttonList[i];
        x = i * w;
        button.frame = CGRectMake(x, y, w, h);
    }
}

@end
