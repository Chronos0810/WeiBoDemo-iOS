//
//  AppDelegate.m
//  WeiboDemo
//
//  Created by Werner on 2019/10/22.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "AppDelegate.h"
#import "LXTabBarController.h"
#import "LXNewFeatureController.h"
#import "CustomTabBarController.h"

#define VersionKey @"version"

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *mWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        
    self.mWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    
    if (![currentVersion isEqualToString:lastVersion]) {
        LXTabBarController *tabBarVC = [[LXTabBarController alloc] init];
        self.mWindow.rootViewController = tabBarVC;
    } else{
        LXNewFeatureController *newFeatureVC = [[LXNewFeatureController alloc] init];
        self.mWindow.rootViewController = newFeatureVC;
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VersionKey];
    }
    
    [self.mWindow makeKeyAndVisible];
    
    return YES;
}

@end
