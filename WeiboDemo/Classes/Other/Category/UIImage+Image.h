//
//  UIImage+Image.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/3.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
