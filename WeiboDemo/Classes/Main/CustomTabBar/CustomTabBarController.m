//
//  CustomTabBarController.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/5.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "LXNavigationController.h"
#import "LXDiscoverViewController.h"
#import "LXHomeViewController.h"
#import "LXMessageViewController.h"
#import "LXMineViewController.h"

@interface CustomTabBarController ()<CustomTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation CustomTabBarController

- (NSMutableArray *)items{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildViewController];
    
    [self setTabBar];
    
}

- (void)setTabBar{
    
    CustomTabBar *tabBar = [[CustomTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    tabBar.delegate = self;
    tabBar.items = self.items;
    [self.tabBar addSubview:tabBar];
}

- (void)tabBar:(CustomTabBar *)tabBar didClickButton:(NSInteger)index{
    self.selectedIndex = index;
}

- (void)setUpAllChildViewController{
    
    LXHomeViewController *homeVC = [[LXHomeViewController alloc] init];
    [self initOneChildViewController:homeVC image:[UIImage imageWithOriginalName:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    
    LXMessageViewController *messageVC = [[LXMessageViewController alloc] init];
    [self initOneChildViewController:messageVC image:[UIImage imageWithOriginalName:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    
    LXDiscoverViewController *discoverVC = [[LXDiscoverViewController alloc] init];
    [self initOneChildViewController:discoverVC image:[UIImage imageWithOriginalName:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    LXMineViewController *mineVC = [[LXMineViewController alloc] init];
    [self initOneChildViewController:mineVC image:[UIImage imageWithOriginalName:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    
}

- (void)initOneChildViewController:(UIViewController *)controller image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = image;
    controller.tabBarItem.selectedImage = selectedImage;
    controller.tabBarItem.badgeValue = @"1000";
    
    [self.items addObject:controller.tabBarItem];
    
    LXNavigationController *navController = [[LXNavigationController alloc] initWithRootViewController:controller];

    [self addChildViewController:navController];
}

@end
