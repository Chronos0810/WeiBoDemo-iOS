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

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *mWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        
    self.mWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    LXNewFeatureController *newFeatureVC = [[LXNewFeatureController alloc] init];
    self.mWindow.rootViewController = newFeatureVC;
    
//    LXTabBarController *tabBarVC = [[LXTabBarController alloc] init];
//    self.mWindow.rootViewController = tabBarVC;
    [self.mWindow makeKeyAndVisible];
    
    return YES;
}

@end
