//
//  LXNavigationController.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/4.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXNavigationController.h"
#import "UIBarButtonItem+Item.h"

@interface LXNavigationController ()<UINavigationControllerDelegate>

@property(nullable,nonatomic,weak) id <UIGestureRecognizerDelegate> popDelegate;

@end

@implementation LXNavigationController

+ (void)initialize
{
    if (self == [LXNavigationController class]) {
        UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;

}

//导航控制器 即将显示新控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

//导航控制器 显示新控制器后
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    } else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count != 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
}



@end
