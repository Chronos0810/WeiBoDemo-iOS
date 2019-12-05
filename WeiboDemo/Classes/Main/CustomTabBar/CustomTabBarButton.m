//
//  CustomTabBarButton.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/5.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "CustomTabBarButton.h"
#import "CustomBadge.h"

@interface CustomTabBarButton()

@property (nonatomic, weak) CustomBadge *badgeView;

@end

@implementation CustomTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{}

- (CustomBadge *)badgeView{
    if (_badgeView == nil) {
        CustomBadge *badge = [CustomBadge buttonWithType:UIButtonTypeCustom];
        [self addSubview:badge];
        
        _badgeView = badge;
    }
    
    return _badgeView;
}

- (void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = _item.badgeValue;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageY = 0;
    CGFloat imageX = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.7;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat TitleY = imageH - 3;
    CGFloat TitleX = 0;
    CGFloat TitleW = self.bounds.size.width;
    CGFloat TitleH = self.bounds.size.height - TitleY;
    self.titleLabel.frame = CGRectMake(TitleX, TitleY, TitleW, TitleH);
    
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

@end
