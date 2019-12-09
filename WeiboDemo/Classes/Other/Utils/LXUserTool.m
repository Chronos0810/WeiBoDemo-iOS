//
//  LXUserTool.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXUserTool.h"
#import "LXUserParam.h"
#import "AccountUtil.h"
#import "LXAccount.h"
#import "NetworkUtil.h"
#import <MJExtension.h>
#import "LXUser.h"

@implementation LXUserTool

+ (void)userInfoWithSuccess:(void(^)(LXUser *userInfo))success failure:(void(^)(NSError *error))failure{
    
    LXUserParam *param = [[LXUserParam alloc] init];
    param.access_token = [AccountUtil account].access_token;
    param.uid = [AccountUtil account].uid;
    
    [NetworkUtil GET:@"https://api.weibo.com/2/users/show.json" parameters:param.mj_keyValues success:^(id  _Nullable responseObject) {
        
        LXUser *userInfo = [LXUser mj_objectWithKeyValues:responseObject];
        if (success) {
            success(userInfo);
        }
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
