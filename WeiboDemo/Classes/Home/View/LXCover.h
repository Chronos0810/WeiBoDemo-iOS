//
//  LXCover.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/4.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXCover;
@protocol LXCoverDelegate <NSObject>

@optional
- (void)didClickCover:(LXCover *)cover;

@end

@interface LXCover : UIView

@property (nonatomic, assign) BOOL dimBackground;
@property (nonatomic, weak) id<LXCoverDelegate> delegate;

+ (instancetype)show;

@end

NS_ASSUME_NONNULL_END
