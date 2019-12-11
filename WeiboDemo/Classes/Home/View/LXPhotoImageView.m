//
//  LXPhotoImageView.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/11.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXPhotoImageView.h"
#import <UIImageView+WebCache.h>
#import "LXPhoto.h"

@interface LXPhotoImageView()

@property (nonatomic, weak) UIImageView *gifImageView;

@end

@implementation LXPhotoImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        UIImageView *gifImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifImageView];
        _gifImageView = gifImageView;
        
    }
    return self;
}

- (void)setPhoto:(LXPhoto *)photo{
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    if ([photo.thumbnail_pic hasSuffix:@".gif"]) {
        self.gifImageView.hidden = NO;
    } else {
        self.gifImageView.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifImageView.x = self.width - self.gifImageView.width;
    self.gifImageView.y = self.height - self.gifImageView.height;
}

@end
