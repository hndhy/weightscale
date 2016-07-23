//
//  HTTableModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTableModelHandler.h"
#import "HTTableViewController.h"

@implementation HTTableModelHandler

- (id)initWithController:(HTTableViewController *)controller
{
  return [super initWithController:controller];
}

#pragma mark - TZXDataSourceDelegate
- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  [self stopAnimating];
  HTTableViewController *controller = (HTTableViewController *)self.controller;
  [controller processResponseData:sender data:data];
  [controller updateScrollSign];
}

- (void)netError:(id)sender error:(NSError*)error
{
  [super netError:sender error:error];
  [self stopAnimating];
  [self handleError:error];
}

- (void)parseError:(id)sender error:(NSError*)error
{
  [super parseError:sender error:error];
  [self stopAnimating];
  [self handleError:error];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
  [super resultError:sender data:data];
  [self stopAnimating];
  [self handleError:nil];
}

- (void)handleError:(NSError*)error
{
//  HHTableViewController *controller = (HHTableViewController *)self.controller;
//  [controller showRefreshView];
}

- (void)stopAnimating
{
  HTTableViewController *controller = (HTTableViewController *)self.controller;
  if (nil != controller.tableView.pullToRefreshView) {
    [controller.tableView.pullToRefreshView stopAnimating];
  }
  if (nil != controller.tableView.infiniteScrollingView) {
    [controller.tableView.infiniteScrollingView stopAnimating];
  }
}

@end
