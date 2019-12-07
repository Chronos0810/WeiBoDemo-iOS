//
//  GlobalUtil.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "GlobalUtil.h"
#import "LXTabBarController.h"
#import "LXNewFeatureController.h"

#define AppVersionKey @"app_version"

@implementation GlobalUtil

+ (UIViewController *)chooseRootViewController
{
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:AppVersionKey];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        
        return [[LXTabBarController alloc] init];
        
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:AppVersionKey];
        return [[LXNewFeatureController alloc] init];
    }
}

@end
