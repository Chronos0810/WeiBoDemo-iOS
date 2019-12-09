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
#import <SDWebImage/UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *mWindow;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
    //后台播放设置session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
        
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

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeMemory completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    player.numberOfLoops = -1;
    [player play];
    
    _player = player;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    
    __block UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:ID];
    }];
}

@end
