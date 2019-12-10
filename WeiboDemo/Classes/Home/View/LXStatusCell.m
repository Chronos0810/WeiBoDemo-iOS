//
//  LXStatusCell.m
//  WeiboDemo
//
//  Created by Luo Xin on 2019/12/9.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXStatusCell.h"
#import "LXOriginalView.h"
#import "LXRetweetView.h"
#import "LXStatusToolBar.h"
#import "LXStatusFrame.h"

@interface LXStatusCell()

@property (nonatomic, weak) LXOriginalView *originalView;
@property (nonatomic, weak) LXRetweetView *retweetView;
@property (nonatomic, weak) LXStatusToolBar *toolBarView;

@end

@implementation LXStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initChildView];
    }
    
    return self;
}

- (void)initChildView{
    LXOriginalView *originalView = [[LXOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    LXRetweetView *retweetView = [[LXRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    LXStatusToolBar *toolBarView = [[LXStatusToolBar alloc] init];
    [self addSubview:toolBarView];
    _toolBarView = toolBarView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setStatusFrame:(LXStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    _originalView.frame = statusFrame.originalViewFrame;
    _originalView.statusFrame = statusFrame;
    
    _retweetView.frame = statusFrame.reTweetViewFrame;
    _retweetView.statusFrame = statusFrame;
    
    _toolBarView.frame = statusFrame.toolBarViewFrame;
}

@end
