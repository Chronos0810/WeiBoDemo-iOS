//
//  MBProgressHUD+Ext.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "MBProgressHUD+Ext.h"

@implementation MBProgressHUD (Ext)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:0.7];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    
    hud.removeFromSuperViewOnHide = YES;
    
    hud.dimBackground = YES;
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end
