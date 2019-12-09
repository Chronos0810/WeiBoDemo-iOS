//
//  NetworkUtil.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkUtil : NSObject

+ (void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(id _Nullable responseObject))success
    failure:(void (^)(NSError * _Nonnull error))failure;

+ (void)POST:(NSString *)URLString
parameters:(nullable id)parameters
   success:(nullable void (^)(id _Nullable responseObject))success
     failure:(nullable void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
