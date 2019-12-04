//
//  LXTabBarController.m
//  WeiboDemo
//
//  Created by Werner on 2019/10/23.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXTabBarController.h"

@interface LXTabBarController ()

@end

@implementation LXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildViewController];
}

- (void)setUpAllChildViewController{
    UIViewController *homeVC = [[UIViewController alloc] init];
    homeVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:homeVC];
    
    UIViewController *messageVC = [[UIViewController alloc] init];
    messageVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:messageVC];
    
    UIViewController *discoverVC = [[UIViewController alloc] init];
    discoverVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:discoverVC];
}

- (void)initOneChildViewController:(UIViewController *)controller image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = image;
        controller.tabBarItem.selectedImage = selectedImage;
    controller.tabBarItem.badgeValue = @"10";

    [self addChildViewController:controller];
}

@end
