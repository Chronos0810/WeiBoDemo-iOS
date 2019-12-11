//
//  LXPhotoImageView.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/11.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXPhoto;
@interface LXPhotoImageView : UIImageView

@property (nonatomic, strong) LXPhoto *photo;

@end

NS_ASSUME_NONNULL_END
