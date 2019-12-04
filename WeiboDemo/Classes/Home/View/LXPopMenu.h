//
//  LXPopMenu.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/4.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXPopMenu : UIImageView

@property (nonatomic, weak) UIView *contentView;

+ (instancetype)showInRect:(CGRect)rect;

+ (void)hide;

@end

NS_ASSUME_NONNULL_END
