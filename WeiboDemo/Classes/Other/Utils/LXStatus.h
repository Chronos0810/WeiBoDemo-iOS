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

@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int reposts_count;
@property (nonatomic, assign) int attitudes_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) LXStatus *retweeted_status;

@end

NS_ASSUME_NONNULL_END
