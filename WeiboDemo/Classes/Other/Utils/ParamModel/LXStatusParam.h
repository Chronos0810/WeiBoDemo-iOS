//
//  LXStatusParam.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXStatusParam : NSObject

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *since_id;
@property (nonatomic, copy) NSString *max_id;

@end

NS_ASSUME_NONNULL_END
