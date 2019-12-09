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

@interface LXStatusCell()

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
    
    LXRetweetView *retweetView = [[LXRetweetView alloc] init];
    [self addSubview:retweetView];
    
    LXStatusToolBar *toolBarView = [[LXStatusToolBar alloc] init];
    [self addSubview:toolBarView];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

@end
