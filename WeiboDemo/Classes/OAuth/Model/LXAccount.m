//
//  LXAccount.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXAccount.h"
#import <MJExtension.h>

#define AccountToekKey @"account_token_key"
#define ExpiresInKey @"expires_in"
#define UIDKey @"uid"
#define ExpiresDateKey @"expires_date"
#define NameKey @"name"

@implementation LXAccount

MJCodingImplementation

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    LXAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    GlobalLog(@"--forUndefinedKey--%@",key);
}

//- (void)encodeWithCoder:(NSCoder *)coder
//{
//    [coder encodeObject:_access_token forKey:AccountToekKey];
//    [coder encodeObject:_expires_in forKey:ExpiresInKey];
//    [coder encodeObject:_uid forKey:UIDKey];
//    [coder encodeObject:_expires_date forKey:ExpiresDateKey];
//    [coder encodeObject:_name forKey:NameKey];
//
//}
//
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super init];
//    if (self) {
//        _access_token = [coder decodeObjectForKey:AccountToekKey];
//        _expires_in = [coder decodeObjectForKey:ExpiresInKey];
//        _uid = [coder decodeObjectForKey:UIDKey];
//        _expires_date = [coder decodeObjectForKey:ExpiresDateKey];
//        _name = [coder decodeObjectForKey:NameKey];
//    }
//    return self;
//}

@end
