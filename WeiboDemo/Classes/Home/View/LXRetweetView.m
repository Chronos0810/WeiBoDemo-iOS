//
//  LXRetweetView.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXRetweetView.h"

@interface LXRetweetView()

@property (nonatomic, weak) UILabel *nameView;
@property (nonatomic, weak) UILabel *textView;

@end

@implementation LXRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initChildView];
    }
    return self;
}

- (void)initChildView{
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    _nameView = nameView;
    
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    _textView = textView;
}

@end
