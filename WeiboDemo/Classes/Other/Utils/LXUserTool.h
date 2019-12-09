//
//  LXUserTool.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXUser;

NS_ASSUME_NONNULL_BEGIN

@interface LXUserTool : NSObject

+ (void)userInfoWithSuccess:(void(^)(LXUser *userInfo))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
