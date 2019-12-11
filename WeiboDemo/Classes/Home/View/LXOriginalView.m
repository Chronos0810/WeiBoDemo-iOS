//
//  LXOriginalView.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXOriginalView.h"
#import "LXStatus.h"
#import "LXStatusFrame.h"
#import "LXUser.h"
#import <UIImageView+WebCache.h>
#import "LXPhotosView.h"

@interface LXOriginalView()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameView;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) UILabel *timeView;
@property (nonatomic, weak) UILabel *sourceView;
@property (nonatomic, weak) UILabel *textView;
@property (nonatomic, weak) LXPhotosView *photosView;

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
    nameView.font = CellNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = CellTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = CellSourceFont;
    sourceView.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CellTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    LXPhotosView *photosView = [[LXPhotosView alloc] init];
    [self addSubview:photosView];
     _photosView = photosView;
}

- (void)setStatusFrame:(LXStatusFrame *)statusFrame{
    
    _statusFrame = statusFrame;
    
    [self initViewFrame];
    
    [self initData];
}

- (void)initViewFrame{
    
    _iconView.frame = _statusFrame.originalIconFrame;
    _nameView.frame = _statusFrame.originalNameFrame;
    if (_statusFrame.status.user.isVip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusFrame.originalVipFrame;
    } else {
        _vipView.hidden = YES;
    }
    _timeView.frame = _statusFrame.originalTimeFrame;
    _sourceView.frame = _statusFrame.originalSourceFrame;
    _textView.frame = _statusFrame.originalTextFrame;
    _photosView.frame = _statusFrame.originalPhotosFrame;
    
}

- (void)initData{
    
    LXStatus *status = _statusFrame.status;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if (status.user.isVip) {
        _nameView.textColor = [UIColor redColor];
    } else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    _timeView.text = status.created_at;
    
    _sourceView.text = status.source;
    
    _textView.text = status.text;
    
    _photosView.pic_urls = _statusFrame.status.pic_urls;
    
}

@end
