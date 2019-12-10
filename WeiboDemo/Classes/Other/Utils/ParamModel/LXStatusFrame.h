//
//  LXStatusFrame.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/10.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LXStatus;

@interface LXStatusFrame : NSObject

@property (nonatomic, strong) LXStatus *status;

@property (nonatomic, assign) CGRect originalViewFrame;
@property (nonatomic, assign) CGRect originalIconFrame;
@property (nonatomic, assign) CGRect originalNameFrame;
@property (nonatomic, assign) CGRect originalVipFrame;
@property (nonatomic, assign) CGRect originalTimeFrame;
@property (nonatomic, assign) CGRect originalSourceFrame;
@property (nonatomic, assign) CGRect originalTextFrame;

@property (nonatomic, assign) CGRect reTweetViewFrame;
@property (nonatomic, assign) CGRect reTweetNameFrame;
@property (nonatomic, assign) CGRect reTweetTextFrame;

@property (nonatomic, assign) CGRect toolBarViewFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
