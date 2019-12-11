//
//  LXHomeViewController.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/4.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXHomeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "LXTitleButton.h"
#import "LXCover.h"
#import "LXPopMenu.h"
#import "LXOneViewController.h"
#import "LXStatus.h"
#import "LXUser.h"
#import <SDWebImage/SDWebImage.h>
#import "MJRefresh.h"
#import "LXStatusTool.h"
#import "LXUserTool.h"
#import "LXAccount.h"
#import "AccountUtil.h"
#import "LXStatusCell.h"
#import "LXStatusFrame.h"

@interface LXHomeViewController ()<LXCoverDelegate>

@property (nonatomic, strong) LXOneViewController *one;
@property (nonatomic, weak) LXTitleButton *titleButton;
@property (nonatomic, strong) NSMutableArray *statusFrameList;

@end

@implementation LXHomeViewController

- (LXOneViewController *)one{
    if (_one == nil) {
        _one = [[LXOneViewController alloc] init];
    }
    
    return _one;
}

- (NSMutableArray *)statusFrameList{
    if (_statusFrameList == nil) {
        _statusFrameList = [NSMutableArray array];
    }
    
    return _statusFrameList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    [self setUpNavigationBar];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getLatestNews];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreNews];
    }];
    
    [LXUserTool userInfoWithSuccess:^(LXUser * _Nonnull userInfo) {
        
        [self.titleButton setTitle:userInfo.name forState:UIControlStateNormal];
        LXAccount *account = [AccountUtil account];
        account.name = userInfo.name;
        [AccountUtil saveAccount:account];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)setUpNavigationBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    LXTitleButton *titleButton = [LXTitleButton buttonWithType:UIButtonTypeCustom];
    
    NSString *title = [AccountUtil account].name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    titleButton.adjustsImageWhenHighlighted = NO;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    _titleButton = titleButton;
    
    self.navigationItem.titleView = titleButton;
}

- (void)searchFriend{
    
    self.one.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: self.one animated:YES];
}

- (void)pop{
    
    
}

- (void)titleClick:(UIButton *)button{
    button.selected = !button.selected;
    
    LXCover *cover = [LXCover show];
    cover.dimBackground = true;
    cover.delegate = self;
    
    CGFloat popY = CGRectGetMaxY(self.navigationController.navigationBar.frame) - 10;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popW = 200;
    CGFloat popH = popW;
    
    LXPopMenu *pop = [LXPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    pop.contentView = self.one.view;
}

- (void)didClickCover:(LXCover *)cover{
    [LXPopMenu hide];
    self.titleButton.selected = NO;
}

- (void)refresh{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - get latest news
- (void)getLatestNews{
    
    NSString *sinceId = nil;
    if (self.statusFrameList.count) {
        LXStatus *status = [self.statusFrameList[0] status];
        sinceId = [status id];
    }
    [LXStatusTool newStatusWithSinceId:sinceId success:^(NSArray * _Nonnull statuses) {
        
        [self.tableView.mj_header endRefreshing];
        
        NSMutableArray *frameList = [NSMutableArray array];
        for (LXStatus *status in statuses) {
            LXStatusFrame *statusFrame = [[LXStatusFrame alloc] init];
            statusFrame.status = status;
            [frameList addObject:statusFrame];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statusFrameList insertObjects:frameList atIndexes:indexSet];
        [self.tableView reloadData];
        
        [self showNewStatusCount:statuses.count];
        
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)showNewStatusCount:(NSUInteger)count{
    if (count == 0) return;
    
    CGFloat w = self.view.width;
    CGFloat h = 35;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    label.text = [NSString stringWithFormat:@"最新微博数:%lu",(unsigned long)count];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];

}

#pragma mark - load more
- (void)loadMoreNews{
    
    NSString *maxIdStr = nil;
    if (self.statusFrameList.count) {
        LXStatus *status = [[self.statusFrameList lastObject] status];
        long long maxId = [[status id] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld", maxId];
    }
    [LXStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray * _Nonnull statuses) {
        
        [self.tableView.mj_footer endRefreshing];
        
        NSMutableArray *frameList = [NSMutableArray array];
        for (LXStatus *status in statuses) {
            LXStatusFrame *statusFrame = [[LXStatusFrame alloc] init];
            statusFrame.status = status;
            [frameList addObject:statusFrame];
        }
        [self.statusFrameList addObjectsFromArray:frameList];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXStatusCell *cell = [LXStatusCell cellWithTableView:tableView];
    
    LXStatusFrame *statusFrame = self.statusFrameList[indexPath.row];
    cell.statusFrame = statusFrame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXStatusFrame *statusFrame = self.statusFrameList[indexPath.row];
    return statusFrame.cellHeight;
}


@end
