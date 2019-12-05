//
//  LXNewFeatureCell.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/5.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end

NS_ASSUME_NONNULL_END
