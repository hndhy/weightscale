//
//  HTTableViewController.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "HTTableView.h"
#import "SVPullToRefresh.h"
#import "BaseResponse.h"

@interface HTTableViewController : HTBaseViewController

@property (nonatomic, strong) HTTableView *tableView;
@property (nonatomic, strong) HTTextField *searchTextField;

- (void)hookPullScrool:(BOOL)pullTorefresh loadMore:(BOOL)loadMore;

- (void)pullRefreshData; // called when pull to refresh, need to be reimplemented
- (BOOL)hasMoreData; // called when load data success, need to be reimplemented
- (void)loadMoreData; // called when scroll to get more data, need to be reimplemented
- (void)updateScrollSign; //  更新滚动标识

- (void)processResponseData:(id)sender data:(BaseResponse*)data; // called when load data success, need to be reimplemented

- (void)setNavigationItem:(NSString *)title;
- (void)onSearchClick:(id)sender;

@end
