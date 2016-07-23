//
//  HTTableViewController.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTableViewController.h"

static const int kViewTag = 1024;

@interface HTTableViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic, assign) BOOL showPullToRefresh;
@property (nonatomic, assign) BOOL showLoadMore;

@end

@implementation HTTableViewController

- (void)initView
{
  [self.view addTapCallBack:self sel:@selector(didTapAnywhere:)];
  for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
    recognizer.delegate = self;
  }
}

- (void)hookPullScrool:(BOOL)pullToRefresh loadMore:(BOOL)loadMore
{
  self.showPullToRefresh = pullToRefresh;
  self.showLoadMore = loadMore;
  __weak HTTableViewController *weakSelf = self;
  // setup pull-to-refresh
  if (pullToRefresh) {
    [self.tableView addPullToRefreshWithActionHandler:^{
      [weakSelf pullRefreshView];
    }];
  }
  
  // setup infinite scrolling
  if (loadMore) {
    [self.tableView addInfiniteScrollingWithActionHandler:^{
      [weakSelf scrollLoadMoreData];
    }];
  }
  self.tableView.showsPullToRefresh = NO;
  self.tableView.showsInfiniteScrolling = NO;
}

- (void)pullRefreshView
{
  [self pullRefreshData];
}

- (void)scrollLoadMoreData
{
  if ([self hasMoreData])
    [self loadMoreData];
}

- (void)pullRefreshData
{
  
}

- (BOOL)hasMoreData
{
  return NO;
}

- (void)loadMoreData
{
  NSLog(@"load more data");
}

- (void)updateScrollSign
{
  if (self.showPullToRefresh) {
    self.tableView.showsPullToRefresh = YES;
  }
  if (self.showLoadMore) {
    if ([self hasMoreData]) {
      self.tableView.showsInfiniteScrolling = YES;
    } else {
      self.tableView.showsInfiniteScrolling = NO;
    }
  }
}

- (void)processResponseData:(id)sender data:(BaseResponse *)data
{
  
}

- (void)refreshView
{
  [super refreshView];
  self.tableView.showsPullToRefresh = NO;
}

- (void)setNavigationItem:(NSString *)title
{
  UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 271.0f, 44.0f)];
  titleView.backgroundColor = [UIColor clearColor];
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(0, 0, 36.0f, 44.0f)
                                        withSize:18.0f withColor:UIColorFromRGB(60.0f, 60.0f, 60.0f)];
  label.text = title;
  label.width = label.contentWidth;
  [label addTapCallBack:self sel:@selector(onBackViewController:)];
  [titleView addSubview:label];
  UIImageView *searchInputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(label.right + 15.0f, 0,
                                                                                    titleView.width - label.right - 15.0f, 29.0f)];
  searchInputImageView.centerY = titleView.centerY;
  searchInputImageView.image = [[UIImage imageNamed:@"search_input.png"] stretchableImageWithLeftCapWidth:38 topCapHeight:0];
//  [titleView addSubview:searchInputImageView];
  self.searchTextField = [[HTTextField alloc] initWithFrame:CGRectMake(searchInputImageView.left + 20.0f, searchInputImageView.top,
                                                                       searchInputImageView.width - 20.0f - 53.0f, 29.0f)];
  self.searchTextField.hint = @"请输入内容...";
  self.searchTextField.delegate = self;
  [self setTextAttributes:self.searchTextField];
//  [titleView addSubview:self.searchTextField];
  UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(self.searchTextField.right, 0, 53.0f, 44.0f)];
  [searchButton setImage:[UIImage imageNamed:@"search_icon_normal.png"] forState:UIControlStateNormal];
  [searchButton setImage:[UIImage imageNamed:@"search_icon_pressed.png"] forState:UIControlStateHighlighted];
  [searchButton addTarget:self action:@selector(onSearchClick:) forControlEvents:UIControlEventTouchUpInside];
//  [titleView addSubview:searchButton];
  self.navigationItem.titleView = titleView;
}

- (void)onSearchClick:(id)sender
{
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  UIView *view = [[UIView alloc] initWithFrame:window.frame];
  view.tag = kViewTag;
  view.backgroundColor = [UIColor clearColor];
  [window addSubview:view];
  [view addTapCallBack:self sel:@selector(didTapAnywhere:)];
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer
{
  if (self.searchTextField.isFirstResponder) {
    [self.searchTextField resignFirstResponder];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *view = [window viewWithTag:kViewTag];
    [view removeFromSuperview];
  }
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
    return NO;
  }
  return YES;   
}

@end
