//
//  LXStatus.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LXUser;
@interface LXStatus : NSObject

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) LXUser *user;

@end

NS_ASSUME_NONNULL_END
