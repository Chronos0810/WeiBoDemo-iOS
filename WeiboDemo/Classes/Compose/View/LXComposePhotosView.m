//
//  LXComposePhotosView.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/12.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXComposePhotosView.h"

@implementation LXComposePhotosView

- (void)setImage:(UIImage *)image{
    _image = image;
    
    UIImageView *imageView= [[UIImageView alloc] init];
    imageView.image = image;
    
    [self addSubview:imageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger columnCount = 3;
    CGFloat margin = 10;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat wh = (self.width - (columnCount - 1)*margin) / columnCount;
    
    NSInteger column = 0;
    NSInteger row = 0;
    
    for (int i = 0 ; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        column = i % columnCount;
        row = i / columnCount;
        x = column * (wh + margin);
        y = row * (wh + margin);
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
