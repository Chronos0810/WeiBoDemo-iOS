//
//  LXAccountParam.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXAccountParam : NSObject

/**
 *  AppKey
 */
@property (nonatomic, copy) NSString *client_id;
/**
 *  AppSecret
 */
@property (nonatomic, copy) NSString *client_secret;
/**
 *  请求的类型,填写authorization_code
 */
@property (nonatomic, copy) NSString *grant_type;
/**
 *  调用authorize获得的code值
 */
@property (nonatomic, copy) NSString *code;
/**
 *  回调地址
 */
@property (nonatomic, copy) NSString *redirect_uri;

@end

NS_ASSUME_NONNULL_END
