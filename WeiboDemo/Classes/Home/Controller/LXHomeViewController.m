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
#import "AFNetworking.h"
#import "AccountUtil.h"
#import "LXAccount.h"
#import "MJExtension.h"
#import "LXStatus.h"
#import "LXUser.h"
#import <SDWebImage/SDWebImage.h>

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
    
    [self getLatestNews];
}

- (void)setUpNavigationBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    LXTitleButton *titleButton = [LXTitleButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
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

#pragma mark - get latest news
- (void)getLatestNews{
    LXAccount *account = [AccountUtil account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
                                   
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@%@",BASE_URL,@"/2/statuses/home_timeline.json"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *responseArr = responseObject[@"statuses"];
        self.statusList = [LXStatus mj_objectArrayWithKeyValuesArray:responseArr];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GlobalLog(@"%@", error);
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    LXStatus *status = self.statusList[indexPath.row];\
    cell.textLabel.text = status.user.name;
    cell.detailTextLabel.text = status.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:nil];
    
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
