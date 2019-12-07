//
//  AccountUtil.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LXAccount;
@interface AccountUtil : NSObject

+ (void)saveAccount:(LXAccount *)account;

+ (LXAccount *)account;

@end

NS_ASSUME_NONNULL_END
