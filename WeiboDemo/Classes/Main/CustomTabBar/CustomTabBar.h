//
//  CustomTabBar.h
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/5.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CustomTabBar;
@protocol CustomTabBarDelegate <NSObject>

@optional
- (void) tabBar:(CustomTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface CustomTabBar : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<CustomTabBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
