//
//  AppDelegate.m
//  WeiboDemo
//
//  Created by Werner on 2019/10/22.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "AppDelegate.h"
#import "LXOAuthViewController.h"
#import "AccountUtil.h"
#import "GlobalUtil.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *mWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        
    self.mWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if ([AccountUtil account]) {
        self.mWindow.rootViewController = [GlobalUtil chooseRootViewController];;
    } else {
        LXOAuthViewController *oauthVC = [[LXOAuthViewController alloc] init];
        self.mWindow.rootViewController = oauthVC;
    }
    
    [self.mWindow makeKeyAndVisible];
    
    return YES;
}

@end
