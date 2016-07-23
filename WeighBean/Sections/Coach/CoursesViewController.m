//
//  CoursesViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/11.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "CoursesViewController.h"
#import "WebViewDetailViewController.h"
#import "LibMacro.h"

#import <RESideMenu.h>

@interface CoursesViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *oldWebView;
@property (nonatomic, strong) UIWebView *ysWebView;
@property (nonatomic, strong) UIWebView *ydWebView;
@property (nonatomic, strong) UIWebView *xlWebView;
@property (nonatomic, strong) UIWebView *trWebView;
@property (nonatomic, strong) UILabel *oldLabel;
@property (nonatomic, strong) NSString *userId;

@end

@implementation CoursesViewController

- (void)initNavbar
{
  self.title = @"优生活教程";
  UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
  [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
  [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
  self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initView
{
  UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 35.0f)];
  titleView.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
  [self.view addSubview:titleView];
  CGFloat margin = (titleView.width - 34.0f - 56.0f * 4) / 3.0f;
  UILabel *ysLabel = [UILabel createLabelWithFrame:CGRectMake(17.0f, 0, 56.0f, 25.0f)
                                          withSize:16.0f withColor:UIColorFromRGB(33.0f, 160.0f, 204.0f)];
  ysLabel.backgroundColor = UIColorFromRGB(152.0f, 226.0f, 252.0f);
  ysLabel.layer.cornerRadius = 4.0f;
  ysLabel.layer.masksToBounds = YES;
  ysLabel.textAlignment = NSTextAlignmentCenter;
  ysLabel.text = @"饮食";
  ysLabel.tag = 0;
  [ysLabel addTapCallBack:self sel:@selector(onTitleClick:)];
  [self.view addSubview:ysLabel];
  self.oldLabel = ysLabel;
  self.ysWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, titleView.bottom, self.view.width,
                                                                     SCREEN_HEIGHT_EXCEPTNAVANDTAB - titleView.height)];
  self.ysWebView.delegate = self;
  self.ysWebView.tag = 0;
  [self.view addSubview:self.ysWebView];
  self.oldWebView = self.ysWebView;
  UILabel *ydLabel = [UILabel createLabelWithFrame:CGRectMake(ysLabel.right + margin, 0, 56.0f, 25.0f)
                                          withSize:16.0f withColor:[UIColor whiteColor]];
  ydLabel.layer.cornerRadius = 4.0f;
  ydLabel.layer.masksToBounds = YES;
  ydLabel.textAlignment = NSTextAlignmentCenter;
  ydLabel.text = @"运动";
  ydLabel.tag = 1;
  [ydLabel addTapCallBack:self sel:@selector(onTitleClick:)];
  [self.view addSubview:ydLabel];
  self.ydWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, titleView.bottom, self.view.width,
                                                                     SCREEN_HEIGHT_EXCEPTNAVANDTAB - titleView.height)];
  self.ydWebView.delegate = self;
  self.ydWebView.tag = 1;
  self.ydWebView.hidden = YES;
  [self.view addSubview:self.ydWebView];
  UILabel *xlLabel = [UILabel createLabelWithFrame:CGRectMake(ydLabel.right + margin, 0, 56.0f, 25.0f)
                                          withSize:16.0f withColor:[UIColor whiteColor]];
  xlLabel.layer.cornerRadius = 4.0f;
  xlLabel.layer.masksToBounds = YES;
  xlLabel.textAlignment = NSTextAlignmentCenter;
  xlLabel.text = @"心灵";
  xlLabel.tag = 2;
  [xlLabel addTapCallBack:self sel:@selector(onTitleClick:)];
  [self.view addSubview:xlLabel];
  self.xlWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, titleView.bottom, self.view.width,
                                                                     SCREEN_HEIGHT_EXCEPTNAVANDTAB - titleView.height)];
  self.xlWebView.delegate = self;
  self.xlWebView.tag = 2;
  self.xlWebView.hidden = YES;
  [self.view addSubview:self.xlWebView];
  UILabel *trLabel = [UILabel createLabelWithFrame:CGRectMake(xlLabel.right + margin, 0, 56.0f, 25.0f)
                                          withSize:16.0f withColor:[UIColor whiteColor]];
  trLabel.layer.cornerRadius = 4.0f;
  trLabel.layer.masksToBounds = YES;
  trLabel.textAlignment = NSTextAlignmentCenter;
  trLabel.text = @"TR90";
  trLabel.tag = 3;
  [trLabel addTapCallBack:self sel:@selector(onTitleClick:)];
  [self.view addSubview:trLabel];
  self.trWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, titleView.bottom, self.view.width,
                                                                     SCREEN_HEIGHT_EXCEPTNAVANDTAB - titleView.height)];
  self.trWebView.delegate = self;
  self.trWebView.tag = 3;
  self.trWebView.hidden = YES;
  [self.view addSubview:self.trWebView];
  HTUserData *userData = [HTUserData sharedInstance];
  self.userId = userData.uid;
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/course.htm?os=ios&uid=%@&channel=yinshi", WEB_URL, self.userId]];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  [self.oldWebView loadRequest:request];
  [self showHUD];
}

- (void)onTitleClick:(UITapGestureRecognizer *)sender
{
  if (self.oldLabel) {
    self.oldLabel.textColor = [UIColor whiteColor];
    self.oldLabel.backgroundColor = [UIColor clearColor];
  }
  UILabel *label = (UILabel *)sender.view;
  label.backgroundColor = UIColorFromRGB(152.0f, 226.0f, 252.0f);
  label.textColor = UIColorFromRGB(33.0f, 160.0f, 204.0f);
  self.oldLabel = label;
  self.oldWebView.hidden = YES;
  if (0 == label.tag) {
    self.oldWebView = self.ysWebView;
    if (self.ysWebView.tag > 0) {
      NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/course.htm?os=ios&uid=%@&channel=yinshi", WEB_URL, self.userId]];
      NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
      [self.oldWebView loadRequest:request];
      [self showHUD];
    }
  } else if (1 == label.tag) {
    self.oldWebView = self.ydWebView;
    if (self.ydWebView.tag > 0) {
      NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/course.htm?os=ios&uid=%@&channel=yundong", WEB_URL, self.userId]];
      NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
      [self.oldWebView loadRequest:request];
      [self showHUD];
    }
  } else if (2 == label.tag) {
    self.oldWebView = self.xlWebView;
    if (self.xlWebView.tag > 0) {
      NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/course.htm?os=ios&uid=%@&channel=xinling", WEB_URL, self.userId]];
      NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
      [self.oldWebView loadRequest:request];
      [self showHUD];
    }
  } else if (3 == label.tag) {
    self.oldWebView = self.trWebView;
    if (self.trWebView.tag > 0) {
      NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/course.htm?os=ios&uid=%@&channel=tr90", WEB_URL, self.userId]];
      NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
      [self.oldWebView loadRequest:request];
      [self showHUD];
    }
  }
  self.oldWebView.hidden = NO;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [self hideHUD];
  webView.tag = -1;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  [self hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"CoursesViewController=%@",urlString);
    
    NSArray *urlComps = [urlString componentsSeparatedByString:@"yd://"];
    
    if([urlComps count]>1)
    {
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@"?"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:1];
        NSArray *parms=  [funcStr componentsSeparatedByString:@"&"];
        NSMutableDictionary *itemDic=[[NSMutableDictionary alloc]init];
        for (NSString *str  in parms) {
            NSArray *item=[str componentsSeparatedByString:@"="];
            [itemDic setObject:item[1] forKey:item[0]];
        }
        
        NSLog(@"action = %@",[itemDic objectForKey:@"action"]);
        
        NSString *action = [itemDic objectForKey:@"action"];
        NSString *uid = [itemDic objectForKey:@"uid"];
        NSString *webid = [itemDic objectForKey:@"cid"];
        NSString *title = [itemDic objectForKey:@"title"];
        
        NSString *url = [NSString stringWithFormat:@"%@/%@.htm?os=%@&uid=%@&cid=%@", WEB_URL, action,@"ios",uid,webid];
        NSLog(@"after url = %@",url);
        
        WebViewDetailViewController *courseDetailVC = [[WebViewDetailViewController alloc]init];
        courseDetailVC.titleName = title;
        courseDetailVC.urlName = url;
        
        if (self.top)
        {
            [self.top.navigationController pushViewController:courseDetailVC animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:courseDetailVC animated:YES];
        }
    }
    
    return YES;
}
@end
