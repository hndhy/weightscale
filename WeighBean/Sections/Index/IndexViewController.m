//
//  IndexViewController.m
//  WeighBean
//
//  Created by liumadu on 15/7/27.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "IndexViewController.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"

static int const kPageSize = 4;
static int const kImagePageSize = 6;

@interface IndexViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *dotArray;
@property (nonatomic, assign) int dotIndex;
@property (nonatomic, assign) int currentPageIndex;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation IndexViewController

- (void)initView
{
  self.view.backgroundColor = [UIColor redColor];
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
  self.scrollView.showsHorizontalScrollIndicator = NO;
  self.scrollView.showsVerticalScrollIndicator = NO;
  self.scrollView.pagingEnabled = YES;
  self.scrollView.scrollsToTop = NO;
  self.scrollView.delegate = self;
  self.scrollView.contentSize = CGSizeMake(self.scrollView.width * kImagePageSize, self.scrollView.height);
  [self.view addSubview:self.scrollView];
  [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0)];
  self.dotArray = [NSMutableArray arrayWithCapacity:kPageSize];
  CGFloat left = (self.view.width - 5.5f * kPageSize - 7.0f * (kPageSize - 1)) / 2.0f;
  UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
  firstImageView.image = [UIImage imageNamed:@"index_3.png"];
  [self.scrollView addSubview:firstImageView];
  for (int i = 0; i < kPageSize; i++) {
    UIImageView *indexImageView = [[UIImageView alloc] initWithFrame:CGRectMake((i + 1) * self.view.width, 0, self.view.width, self.view.height)];
    indexImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"index_%d.png", i]];
    [self.scrollView addSubview:indexImageView];
    UIImageView *dotView = [[UIImageView alloc] initWithFrame:CGRectMake(left, self.scrollView.bottom - 146.0f, 5.5f, 5.5f)];
    if (i == 0) {
      dotView.image = [UIImage imageNamed:@"index_dot_selected.png"];
    } else {
      dotView.image = [UIImage imageNamed:@"index_dot_normal.png"];
    }
    [self.view addSubview:dotView];
    [self.dotArray addObject:dotView];
    left = dotView.right + 7.0f;
  }
  UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width * (kImagePageSize - 1),
                                                                             0, self.view.width, self.view.height)];
  lastImageView.image = [UIImage imageNamed:@"index_0.png"];
  [self.scrollView addSubview:lastImageView];
  UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 123.0f, 166.0f, 30.0f)];
  registerButton.centerX = self.view.centerX;
  [registerButton setBackgroundImage:[UIImage imageNamed:@"index_register.png"] forState:UIControlStateNormal];
  [registerButton addTarget:self action:@selector(onRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:registerButton];
  UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(registerButton.left, registerButton.bottom + 8.0f, 166.0f, 30.0f)];
  [loginButton setBackgroundImage:[UIImage imageNamed:@"index_login.png"] forState:UIControlStateNormal];
  [loginButton addTarget:self action:@selector(onLoginClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:loginButton];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(incrementOffset) userInfo:nil repeats:YES];
     
//    [self otherView];
}

- (void)otherView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"index_new"];
    [self.view addSubview:imageView];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.width - 111*2 - 20)/2, self.view.height - 80.0f, 111, 30.0f)];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_new"] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [loginButton addTarget:self action:@selector(onLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(loginButton.right + 20, self.view.height - 80.0f, 111, 30.0f)];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"register_new"] forState:UIControlStateNormal];
    [registerButton setTitle:@"加入我们" forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [registerButton setTitleColor:UIColorFromRGB(55,150,217) forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(onRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
}

- (void)incrementOffset
{
  self.currentPageIndex++;
  BOOL flag = YES;
  if (self.currentPageIndex == kImagePageSize) {
    self.currentPageIndex = 1;
    self.dotIndex = 0;
    flag = NO;
  }
  [self.scrollView setContentOffset:CGPointMake(self.currentPageIndex * self.scrollView.width, 0) animated:flag];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat pageWidth = scrollView.width;
  int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
  self.currentPageIndex = page;
  int tmpIndex = page - 1;
  if (tmpIndex < 0) {
    tmpIndex = 0;
  }
  if (tmpIndex >= kPageSize) {
    tmpIndex = 0;//kPageSize - 1;
  }
  if (tmpIndex != self.dotIndex) {
    self.dotIndex = tmpIndex;
    for (int i = 0; i < kPageSize; i++) {
      UIImageView *imageView = [self.dotArray objectAtIndex:i];
      if (i == self.dotIndex) {
        imageView.image = [UIImage imageNamed:@"index_dot_selected.png"];
      } else {
        imageView.image = [UIImage imageNamed:@"index_dot_normal.png"];
      }
    }
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  if (0 == self.currentPageIndex) {
    [scrollView setContentOffset:CGPointMake((kImagePageSize - 2) * scrollView.width, 0)];
  }
  if (self.currentPageIndex == kImagePageSize -1) {
    [scrollView setContentOffset:CGPointMake(scrollView.width, 0)];
  }
}

#pragma mark - Custom Methods
- (void)onLoginClick:(id)sender
{
  LoginViewController *controller = [[LoginViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)onRegisterClick:(id)sender
{
  RegisterViewController *controller = [[RegisterViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
