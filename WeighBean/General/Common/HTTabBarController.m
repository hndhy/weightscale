//
//  HTBaseTabBarController.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTabBarController.h"

#import "UIView+Ext.h"
#import "UtilsMacro.h"

#import "HTTabBarItem.h"

#import "HTBaseViewController.h"
#import "LoginViewController.h"
#import "HTNavigationController.h"

@interface HTTabBarController()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) HTTabBarItem *selectedItem; // 在bottonbar被选中的GATabBarItem
@property (nonatomic, strong) NSMutableArray *buttonArray; // GATabBarItem 数组
@property (nonatomic, assign) NSInteger readyItemTag; // 准备选中的GATabBarItem tag
@property (nonatomic, assign) CGFloat itemWidth;

@end

@implementation HTTabBarController

- (id)init
{
  self = [super init];
  if (self) {
    self.readyItemTag = 0;
    self.buttonArray = [[NSMutableArray alloc] initWithCapacity:4];
    [self initSubViews];
  }
  return self;
}

-(void)setTitle:(NSString *)title
{
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(0, 0, self.view.width, 44.0f)
                                          withSize:18.0f withColor:UIColorFromRGB(51.0f, 51.0f, 51.0f)];
    label.textColor = [UIColor whiteColor];
    label.text = title;
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  NSUInteger count = [self.navigationController.viewControllers count];
  if (count > 1) {
    if (nil == self.navigationItem.leftBarButtonItem) {
      UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
      [backButton setImage:[UIImage imageNamed:@"black_nav_bar.png"] forState:UIControlStateNormal];
      [backButton addTarget:self action:@selector(onBackViewController:) forControlEvents:UIControlEventTouchUpInside];
      UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
      self.navigationItem.leftBarButtonItem = leftItem;
    }
  }
}

- (void)onBackViewController:(id)sender
{
    if (self.isCanBackBlock&&self.readyItemTag == 0)
    {
        BOOL isCan = self.isCanBackBlock();
        if (isCan)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)initSubViews
{
  self.itemWidth = self.view.width / 3.0f;
  self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 50.0f, self.view.width, 50.0f)];
  self.bottomView.backgroundColor = [UIColor whiteColor];
  self.bottomView.tag = 3;
  [self.view addSubview:self.bottomView];
  //底部bar的item
    /*
  HTTabBarItem *clockInItem = [[HTTabBarItem alloc] initWithFrame:CGRectMake(0, 0, self.itemWidth, self.bottomView.height)];
  [clockInItem setNormal:@"clock_in_tab_bar_normal.png" seleted:@"clock_in_tab_bar_selected.png" title:@"打卡"];
  clockInItem.tag = 0;
  [clockInItem addTapCallBack:self sel:@selector(onClickBottomItem:)];
  [self.bottomView addSubview:clockInItem];
  [self.buttonArray addObject:clockInItem];
  HTTabBarItem *coursesItem = [[HTTabBarItem alloc] initWithFrame:CGRectMake(clockInItem.right, 0, self.itemWidth, self.bottomView.height)];
  [coursesItem setNormal:@"courses_tab_bar_normal.png" seleted:@"courses_tab_bar_selected.png" title:@"教程"];
  coursesItem.tag = 1;
  [coursesItem addTapCallBack:self sel:@selector(onClickBottomItem:)];
  [self.bottomView addSubview:coursesItem];
  [self.buttonArray addObject:coursesItem];
  HTTabBarItem *planItem = [[HTTabBarItem alloc] initWithFrame:CGRectMake(coursesItem.right, 0, self.itemWidth, self.bottomView.height)];
  [planItem setNormal:@"plan_tab_bar_normal.png" seleted:@"plan_tab_bar_selected.png" title:@"计划"];
  planItem.tag = 2;
  [planItem addTapCallBack:self sel:@selector(onClickBottomItem:)];
  [self.bottomView addSubview:planItem];
  [self.buttonArray addObject:planItem];
     */
    
    HTTabBarItem *clockInItem = [[HTTabBarItem alloc] initWithFrame:CGRectMake(0, 0, self.itemWidth, self.bottomView.height)];
    [clockInItem setNormal:@"tab_wj_nor.png" seleted:@"tab_wj_sel.png" title:@"问卷"];
    clockInItem.tag = 0;
    [clockInItem addTapCallBack:self sel:@selector(onClickBottomItem:)];
    [self.bottomView addSubview:clockInItem];
    [self.buttonArray addObject:clockInItem];
    HTTabBarItem *coursesItem = [[HTTabBarItem alloc] initWithFrame:CGRectMake(clockInItem.right, 0, self.itemWidth, self.bottomView.height)];
    [coursesItem setNormal:@"tab_v_nor.png" seleted:@"tab_v_sel.png" title:@""];
    coursesItem.tag = 1;
    [coursesItem addTapCallBack:self sel:@selector(onClickBottomItem:)];
    [self.bottomView addSubview:coursesItem];
    [self.buttonArray addObject:coursesItem];
    HTTabBarItem *planItem = [[HTTabBarItem alloc] initWithFrame:CGRectMake(coursesItem.right, 0, self.itemWidth, self.bottomView.height)];
    [planItem setNormal:@"tab_sz_nor.png" seleted:@"tab_sz_sel.png" title:@"设置"];
    planItem.tag = 2;
    [planItem addTapCallBack:self sel:@selector(onClickBottomItem:)];
    [self.bottomView addSubview:planItem];
    [self.buttonArray addObject:planItem];
    
  //顶部分割线
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bottomView.width, 1.0f)];
  lineView.backgroundColor = UIColorFromRGB(219.0f, 214.0f, 214.0f);
  [self.bottomView addSubview:lineView];
}

- (void)showControllerWithTag:(NSInteger)tag
{
  HTTabBarItem *item = [self.buttonArray objectAtIndex:tag];
  [self switchBottomItem:item];
}

- (void)addViewController:(UIViewController *)viewController
{
  [self addChildViewController:viewController];
  if (self.childViewControllers.count == 1) {
    [self.view insertSubview:viewController.view atIndex:0];
  }
}

- (void)onClickBottomItem:(UITapGestureRecognizer *)recognizer
{
  HTTabBarItem *item = (HTTabBarItem *)recognizer.view;
  [self switchBottomItem:item];
}

- (void)switchBottomItem:(HTTabBarItem *)item
{
  self.readyItemTag = item.tag;
  if (item == self.selectedItem) {
    return;
  }
  [self.selectedItem setSelected:NO];
  [item setSelected:YES];
  self.selectedItem = item;
  UINavigationController *navController = [self.childViewControllers objectAtIndex:item.tag];
  NSArray *views = [self.view subviews];
  for (UIView *view in views) {
    if (view.tag != 3) {
      [view removeFromSuperview];
    }
  }
  [self.view insertSubview:navController.view atIndex:0];
  [self setNeedsStatusBarAppearanceUpdate];
    
    if (item.tag == 1)
    {
        if (self.setTopBlock)
        {
            self.setTopBlock();
        }
    }
    else if(item.tag == 0)
    {
        if (self.setOtherTopBlock)
        {
            self.setOtherTopBlock();
        }
    }
    else
    {
        self.title = @"V战队设置";
        self.navigationItem.rightBarButtonItems = nil;
    }
}

- (BOOL)isLogin
{
  HTAppContext *appContext = [HTAppContext sharedContext];
  if (!ISEMPTY(appContext.uid)) {
    return YES;
  }
  return NO;
}

- (void)showLoginView
{
  LoginViewController *loginViewController = [[LoginViewController alloc] init];
  loginViewController.hiddenNavigationBar = YES;
  HTNavigationController *loginNavController = [[HTNavigationController alloc] initWithRootViewController:loginViewController];
  [self presentViewController:loginNavController animated:YES completion:NULL];
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
  [super setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
  [_bottomView setHidden:hidesBottomBarWhenPushed];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  NSInteger tag = self.selectedItem.tag;
  if (tag > 0) {
    UINavigationController *navController = [self.childViewControllers objectAtIndex:self.selectedItem.tag];
    HTBaseViewController *controller = (HTBaseViewController *)navController.topViewController;
    if (HTBarStyleGreen == controller.barStyle) {
      return UIStatusBarStyleLightContent;
    }
  }
  return UIStatusBarStyleDefault;
}

- (void)dealloc
{
    self.setTopBlock = nil;
}

@end
