//
//  DiaryViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/11.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "DiaryViewController.h"
#import "WebViewDetailViewController.h"
#import "LibMacro.h"
#import "AddLookViewController.h"
#import "TrendListViewController.h"
#import <RESideMenu.h>

@interface DiaryViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation DiaryViewController

- (void)initNavbar
{
    HTUserData *userData = [HTUserData sharedInstance];
    if (userData.isCoach)
    {
        self.title = @"查看日记";
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        //[menuButton setTitle:@"添加" forState:UIControlStateNormal];
        [menuButton setImage:[UIImage imageNamed:@"add_nav_bar.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.rightBarButtonItem = leftItem;
    }
    else
    {
        self.title = userData.nick;
    }
    
    if (self.coachUid.length)
    {
        self.title = @"小组成员";
    }
    else
    {
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (void)initView
{
  self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT_EXCEPTNAV)];
  self.webView.delegate = self;
  [self.view addSubview:self.webView];
  NSString *urlpre = nil;
  HTUserData *userData = [HTUserData sharedInstance];
  if (userData.isCoach)
  {
    urlpre = @"team.htm";
      
  }
  else
  {
    urlpre = @"my_daka_sns.htm";
  }
    NSString *coachUidPara = @"";
    if (self.coachUid.length)
    {
        coachUidPara = [NSString stringWithFormat:@"&coachUid=%@",self.coachUid];
    }
    
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?os=ios&uid=%@%@", WEB_URL, urlpre, userData.uid,coachUidPara]];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  [self.webView loadRequest:request];
  [self showHUD];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  [self hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"DiaryViewController=%@",urlString);

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
        
        NSString *action = [itemDic objectForKey:@"action"];
        NSString *uid = [itemDic objectForKey:@"param"];
        NSString *title = [itemDic objectForKey:@"nick"];
        
        NSString *url = [NSString stringWithFormat:@"%@/%@.htm?os=%@&uid=%@", WEB_URL, action,@"ios",uid];
        WebViewDetailViewController *planDetailVC = [[WebViewDetailViewController alloc]init];
        planDetailVC.titleName = title;
        planDetailVC.urlName = url;
        planDetailVC.otherUid = uid;
        [self.navigationController pushViewController:planDetailVC animated:YES];
        
    }
    
    return YES;
}

- (void)rightAction
{
    AddLookViewController *add = [[AddLookViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}

@end
