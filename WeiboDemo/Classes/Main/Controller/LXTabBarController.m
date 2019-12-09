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
#import "LXMessageViewController.h"
#import "LXMineViewController.h"

//#import <objc/message.h>

@interface LXTabBarController ()<UITabBarDelegate>

@property (nonatomic, weak) LXHomeViewController *mHomeVC;

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
    
    LXTabBar *tabBar = [[LXTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];

    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    //消息机制
//    objc_msgSend(self, @selector(setTabBar:), tabBar);
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 10;
    
}

- (void)setUpAllChildViewController{
    
    LXHomeViewController *homeVC = [[LXHomeViewController alloc] init];
    [self initOneChildViewController:homeVC image:[UIImage imageWithOriginalName:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页" tag:0];
    _mHomeVC = homeVC;
    
    LXMessageViewController *messageVC = [[LXMessageViewController alloc] init];
    [self initOneChildViewController:messageVC image:[UIImage imageWithOriginalName:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息" tag:1];
    
    LXDiscoverViewController *discoverVC = [[LXDiscoverViewController alloc] init];
    [self initOneChildViewController:discoverVC image:[UIImage imageWithOriginalName:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现" tag:2];
    
    LXMineViewController *mineVC = [[LXMineViewController alloc] init];
    [self initOneChildViewController:mineVC image:[UIImage imageWithOriginalName:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我" tag:3];
    
}

- (void)initOneChildViewController:(UIViewController *)controller image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title tag:(int)tag{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = image;
    controller.tabBarItem.selectedImage = selectedImage;
    controller.tabBarItem.badgeValue = @"10";
    controller.tabBarItem.tag = tag;
    
    LXNavigationController *navController = [[LXNavigationController alloc] initWithRootViewController:controller];

    [self addChildViewController:navController];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if (item.tag == 0 && self.selectedIndex == 0) {
        [_mHomeVC refresh];
    }
}

@end
