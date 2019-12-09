//
//  LXOriginalView.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXOriginalView.h"

@interface LXOriginalView()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameView;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) UILabel *timeView;
@property (nonatomic, weak) UILabel *sourceView;
@property (nonatomic, weak) UILabel *textView;

@end

@implementation LXOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initChildView];
    }
    return self;
}

- (void)initChildView{
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    _nameView = nameView;
    
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    UILabel *timeView = [[UILabel alloc] init];
    [self addSubview:timeView];
    _timeView = timeView;
    
    UILabel *sourceView = [[UILabel alloc] init];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    _textView = textView;
}

@end
