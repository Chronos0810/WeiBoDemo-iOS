//
//  LXUser.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXUser : NSObject

@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *location;
//@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *gender;

@end

NS_ASSUME_NONNULL_END
