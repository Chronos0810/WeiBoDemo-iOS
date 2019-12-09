//
//  LXStatusResult.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXStatusResult : NSObject

@property (nonatomic, strong) NSArray *statuses;
@property (nonatomic, assign) int total_number;

@end

NS_ASSUME_NONNULL_END
