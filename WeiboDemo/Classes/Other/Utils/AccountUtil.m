//
//  AccountUtil.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "AccountUtil.h"
#import "LXAccount.h"

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

@end
