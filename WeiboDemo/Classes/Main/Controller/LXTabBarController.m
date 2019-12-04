//
//  LXTabBarController.m
//  WeiboDemo
//
//  Created by Werner on 2019/10/23.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXTabBarController.h"
#import "UIImage+Image.h"
#import "LXTabBar.h"
#import "LXNavigationController.h"
#import "LXDiscoverViewController.h"
#import "LXHomeViewController.h"

//#import <objc/message.h>

@interface LXTabBarController ()

@end

@implementation LXTabBarController

+ (void)initialize
{
    if (self == [LXTabBarController class]) {
        
//        UITabBarItem *item = [UITabBarItem appearance];
        UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSForegroundColorAttributeName] = [UIColor orangeColor];
        [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildViewController];
    
    LXTabBar *tabBar = [[LXTabBar alloc] initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    //消息机制
//    objc_msgSend(self, @selector(setTabBar:), tabBar);
    
}

- (void)setUpAllChildViewController{
    
    LXHomeViewController *homeVC = [[LXHomeViewController alloc] init];
    [self initOneChildViewController:homeVC image:[UIImage imageWithOriginalName:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    
    UIViewController *messageVC = [[UIViewController alloc] init];
    messageVC.view.backgroundColor = [UIColor yellowColor];
    [self initOneChildViewController:messageVC image:[UIImage imageWithOriginalName:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    
    LXDiscoverViewController *discoverVC = [[LXDiscoverViewController alloc] init];
    [self initOneChildViewController:discoverVC image:[UIImage imageWithOriginalName:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    UIViewController *mineVC = [[UIViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor whiteColor];
    [self initOneChildViewController:mineVC image:[UIImage imageWithOriginalName:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    
}

- (void)initOneChildViewController:(UIViewController *)controller image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    controller.tabBarItem.title = title;
    
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor orangeColor];
////    [attr setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    [controller.tabBarItem setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    controller.tabBarItem.image = image;
    controller.tabBarItem.selectedImage = selectedImage;
//    controller.tabBarItem.badgeValue = @"10";
    
    LXNavigationController *navController = [[LXNavigationController alloc] initWithRootViewController:controller];

    [self addChildViewController:navController];
}

@end
