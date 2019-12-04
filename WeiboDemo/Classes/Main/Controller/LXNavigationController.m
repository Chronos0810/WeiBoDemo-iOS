//
//  LXNavigationController.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/4.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXNavigationController.h"

@interface LXNavigationController ()

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

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
