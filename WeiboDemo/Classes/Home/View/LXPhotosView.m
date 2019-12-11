//
//  LXPhotosView.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/11.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXPhotosView.h"
#import <UIImageView+WebCache.h>
#import "LXPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "LXPhotoImageView.h"

@implementation LXPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createChildViews];
    }
    return self;
}

- (void)createChildViews{
    for (int i = 0; i < 9; i++) {
        LXPhotoImageView *photoImageView = [[LXPhotoImageView alloc] init];
        photoImageView.tag = i;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto:)];
        [photoImageView addGestureRecognizer:tapGesture];
        
        [self addSubview:photoImageView];
    }
}

- (void)tapPhoto:(UITapGestureRecognizer *)tapGesture{
    LXPhotoImageView *imageView = (LXPhotoImageView *)tapGesture.view;
    
    NSMutableArray *photoArr = [NSMutableArray array];
    
    int i = 0;
    for (LXPhoto *photo in _pic_urls) {
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = [photo.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = imageView;
        [photoArr addObject:p];
        
        i++;
    }
    
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photoArr;
    browser.currentPhotoIndex = imageView.tag;
    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < self.subviews.count; i++) {
        LXPhotoImageView *imageView =  self.subviews[i];
        if (i < pic_urls.count) {
            imageView.hidden = NO;
            imageView.photo = pic_urls[i];
            
        } else {
            imageView.hidden = YES;
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 80;
    CGFloat h = 80;
    
    int row = 0;
    int column = 0;
    int columnCount = _pic_urls.count == 4 ? 2 : 3;
    
    for (int i = 0; i < _pic_urls.count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        column = i % columnCount;
        row = i / columnCount;
        
        x = column * (w + StatusCellMargin);
        y = row * (h + StatusCellMargin);
        imageView.frame = CGRectMake(x, y, w, h);
    }
}


@end
