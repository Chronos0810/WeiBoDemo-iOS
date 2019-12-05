//
//  LXNewFeatureCell.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/5.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXNewFeatureCell.h"
#import "LXTabBarController.h"

@interface LXNewFeatureCell()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *shareButton;

@property (nonatomic, weak) UIButton *startButton;

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

- (UIButton *)shareButton{
    if (_shareButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"share to friends" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [button sizeToFit];
        
        [self.contentView addSubview:button];
        
        _shareButton = button;
    }
    
    return _shareButton;
}

- (UIButton *)startButton{
    if (_startButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"start hava fun" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        
        [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        
        _startButton = button;
    }
    
    return _startButton;
}

- (void)start{
    LXTabBarController *tabBarVC = [[LXTabBarController alloc] init];
    GlobalKeyWindow.rootViewController = tabBarVC;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    self.shareButton.center = CGPointMake(self.width / 2, self.height * 0.8);
    
    self.startButton.center = CGPointMake(self.width / 2, self.height * 0.86);
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count{
    if (indexPath.row == count - 1) {
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    } else {
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

@end
