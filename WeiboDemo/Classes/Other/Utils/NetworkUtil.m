//
//  NetworkUtil.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "NetworkUtil.h"
#import "AFNetworking.h"

@implementation NetworkUtil

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id _Nullable responseObject))success
    failure:(void (^)(NSError * _Nonnull error))failure
{

    [[AFHTTPSessionManager manager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GlobalLog(@"%@", responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        GlobalLog(@"%@", error);
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^)(id _Nullable responseObject))success
     failure:(nullable void (^)(NSError *error))failure{
    
    [[AFHTTPSessionManager manager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GlobalLog(@"%@", responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        GlobalLog(@"%@", error);
        if (failure) {
            failure(error);
        }
    }];
}

@end
