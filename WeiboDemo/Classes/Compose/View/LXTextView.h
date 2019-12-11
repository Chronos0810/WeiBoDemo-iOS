//
//  LXTextView.h
//  WeiboDemo
//
//  Created by Werner on 2019/12/11.
//  Copyright © 2019 Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTextView : UITextView

@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) BOOL hidePlaceHolder;

@end

NS_ASSUME_NONNULL_END
