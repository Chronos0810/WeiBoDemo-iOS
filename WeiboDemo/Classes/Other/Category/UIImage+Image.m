//
//  UIImage+Image.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/3.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
