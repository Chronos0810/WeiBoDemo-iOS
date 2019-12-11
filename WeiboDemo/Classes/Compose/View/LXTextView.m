//
//  LXTextView.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/11.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXTextView.h"

@interface LXTextView()

@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation LXTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (UILabel *)placeHolderLabel{

    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
        
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder{
    _hidePlaceHolder = hidePlaceHolder;
    self.placeHolderLabel.hidden = hidePlaceHolder;
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    self.placeHolderLabel.text = placeHolder;
    [self.placeHolderLabel sizeToFit];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}

@end
