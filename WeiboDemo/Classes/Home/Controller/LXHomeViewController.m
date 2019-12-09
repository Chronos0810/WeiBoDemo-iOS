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

@interface LXHomeViewController ()<LXCoverDelegate>

@property (nonatomic, strong) LXOneViewController *one;
@property (nonatomic, weak) LXTitleButton *titleButton;
@property (nonatomic, strong) NSMutableArray *statusList;

@end

@implementation LXHomeViewController

- (LXOneViewController *)one{
    if (_one == nil) {
        _one = [[LXOneViewController alloc] init];
    }
    
    return _one;
}

- (NSMutableArray *)statusList{
    if (_statusList == nil) {
        _statusList = [NSMutableArray array];
    }
    
    return _statusList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    if (self.statusList.count) {
        sinceId = [self.statusList[0] id];
    }
    [LXStatusTool newStatusWithSinceId:sinceId success:^(NSArray * _Nonnull statuses) {
        
        [self.tableView.mj_header endRefreshing];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statusList insertObjects:statuses atIndexes:indexSet];
        [self.tableView reloadData];
        
        [self showNewStatusCount:statuses.count];
        
    } failure:^(NSError * _Nonnull error) {
        
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
    if (self.statusList.count) {
        long long maxId = [[[self.statusList lastObject] id] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld", maxId];
    }
    [LXStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray * _Nonnull statuses) {
        
        [self.tableView.mj_footer endRefreshing];
        [self.statusList addObjectsFromArray:statuses];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    LXStatus *status = self.statusList[indexPath.row];\
    cell.textLabel.text = status.user.name;
    cell.detailTextLabel.text = status.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage: [UIImage imageNamed:@"timeline_image_placeholder"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
