//
//  LXComposeToolBar.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/11.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXComposeToolBar;
@protocol LXComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(LXComposeToolBar *)toolBar didClickButton:(NSUInteger)index;

@end


@interface LXComposeToolBar : UIView

@property (nonatomic, weak) id<LXComposeToolBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
