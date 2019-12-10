//
//  LXRetweetView.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXRetweetView.h"
#import "LXStatusFrame.h"
#import "LXStatus.h"
#import "LXUser.h"

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
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

- (void)initChildView{
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CellNameFont;
    nameView.textColor = [UIColor blueColor];
    [self addSubview:nameView];
    _nameView = nameView;
    
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CellTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
}

- (void)setStatusFrame:(LXStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    [self initViewFrame];
    
    [self initData];
    
}

- (void)initViewFrame{
    _nameView.frame = _statusFrame.reTweetNameFrame;
    
    _textView.frame = _statusFrame.reTweetTextFrame;
    
}

- (void)initData{
    
    _nameView.text = [NSString stringWithFormat:@"@%@", _statusFrame.status.retweeted_status.user.name];
    
    _textView.text = _statusFrame.status.retweeted_status.text;
}

@end
