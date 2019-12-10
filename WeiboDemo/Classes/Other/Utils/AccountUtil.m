//
//  AccountUtil.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "AccountUtil.h"
#import "LXAccount.h"
#import "LXAccountParam.h"
#import "NetworkUtil.h"
#import <MJExtension.h>

#define Client_ID    @"1856772886"
#define Redirect_Uri @"http://www.baidu.com"
#define AccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation AccountUtil

static LXAccount *_account;

+ (void)saveAccount:(LXAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFileName];
}

+ (LXAccount *)account
{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFileName];

        // 判断下账号是否过期，如果过期直接返回Nil
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
   
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void(^)(void))success failure:(void(^)(NSError *error))failure{
    LXAccountParam *param = [[LXAccountParam alloc] init];
    param.client_id = Client_ID;
    param.client_secret = @"135260ffad99fdc0f28926810a79fb88";
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = Redirect_Uri;
    
    [NetworkUtil POST:[NSString stringWithFormat:@"%@%@",BASE_URL,@"/oauth2/access_token"] parameters:param.mj_keyValues success:^(id  _Nullable responseObject) {
        
        GlobalLog(@"%@", responseObject);
        LXAccount *account = [LXAccount accountWithDict:responseObject];
        [AccountUtil saveAccount:account];
        
        if (success) {
            success();
        }
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
