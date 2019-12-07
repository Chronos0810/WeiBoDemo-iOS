//
//  MBProgressHUD+Ext.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Ext)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
