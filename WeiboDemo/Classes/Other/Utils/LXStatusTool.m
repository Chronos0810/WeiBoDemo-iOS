//
//  LXStatusTool.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXStatusTool.h"
#import "NetworkUtil.h"
#import "AccountUtil.h"
#import "LXAccount.h"
#import "LXStatusParam.h"
#import "LXStatusResult.h"
#import "LXStatus.h"
#import "MJExtension.h"
#import "LXPhoto.h"

@implementation LXStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure{
            
    LXStatusParam *param = [[LXStatusParam alloc] init];
    param.access_token = [AccountUtil account].access_token;
    if (sinceId) {
        param.since_id = sinceId;
    }
    
    [NetworkUtil GET:[NSString stringWithFormat:@"%@%@",BASE_URL,@"/2/statuses/home_timeline.json"] parameters:param.mj_keyValues success:^(id _Nullable responseObject) {
        
        [LXStatusResult mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"statuses":[LXStatus class]};
        }];
        
        [LXStatus mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"pic_urls":[LXPhoto class]};
        }];
        
        LXStatusResult *result = [LXStatusResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
                
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure{
    
    LXStatusParam *param = [[LXStatusParam alloc] init];
    param.access_token = [AccountUtil account].access_token;
    if (maxId) {
        param.max_id = maxId;
    }
    [NetworkUtil GET:[NSString stringWithFormat:@"%@%@",BASE_URL,@"/2/statuses/home_timeline.json"] parameters:param.mj_keyValues success:^(id  _Nullable responseObject) {
           
        [LXStatusResult mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"statuses":[LXStatus class]};
        }];
        
        [LXStatus mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"pic_urls":[LXPhoto class]};
        }];
        
        LXStatusResult *result = [LXStatusResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
        
       } failure:^(NSError * _Nonnull error) {
           if (failure) {
               failure(error);
           }
       }];
}

@end
