//
//  LXNewFeatureCell.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/5.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXNewFeatureCell.h"

@interface LXNewFeatureCell()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation LXNewFeatureCell

- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageview = [[UIImageView alloc] init];
        _imageView = imageview;
        [self.contentView addSubview:imageview];
    }
    
    return _imageView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}

@end
