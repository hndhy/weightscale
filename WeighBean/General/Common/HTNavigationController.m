//
//  HTNaviHTtionController.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTNavigationController.h"

#import "UtilsMacro.h"

#import "HTNavigationBar.h"
#import "HTTabBarController.h"
#import "HTBaseViewController.h"

@interface HTNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation HTNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (id)init
{
  return [super initWithNavigationBarClass:[HTNavigationBar class] toolbarClass:nil];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
  self = [super initWithNavigationBarClass:[HTNavigationBar class] toolbarClass:nil];
  if (self) {
    self.viewControllers = @[rootViewController];
    self.delegate = self;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  __weak typeof (self) weakSelf = self;
  if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.interactivePopGestureRecognizer.delegate = weakSelf;
  }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  NSUInteger count = self.childViewControllers.count;
  if (count == 1) {
    if (IsKindOfClass(self.parentViewController, HTTabBarController)) {
      HTTabBarController *barController = (HTTabBarController *)self.parentViewController;
      [barController setHidesBottomBarWhenPushed:YES];
    }
  }
  if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.interactivePopGestureRecognizer.enabled = NO;
  }
  [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
  int count = (int)self.childViewControllers.count;
  if (count == 2) {
    if (IsKindOfClass(self.parentViewController, HTTabBarController)) {
      HTTabBarController *barController = (HTTabBarController *)self.parentViewController;
      [barController setHidesBottomBarWhenPushed:NO];
    }
  }
  return [super popViewControllerAnimated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

#pragma mark - UINavitionControllerDelete Functions
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    navigationController.interactivePopGestureRecognizer.enabled = YES;
  }
}

@end
