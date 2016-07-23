//
//  PlanViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/11.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "PlanViewController.h"

#import "LibMacro.h"

#import <RESideMenu.h>
#import "WebViewDetailViewController.h"

@interface PlanViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation PlanViewController

- (void)initNavbar
{
  self.title = @"优生活计划";
  UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
  [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
  [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
  self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initView
{
  self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT_EXCEPTNAVANDTAB)];
  self.webView.delegate = self;
  [self.view addSubview:self.webView];
  HTUserData *userData = [HTUserData sharedInstance];
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/plan_main.htm?os=ios&uid=%@", WEB_URL, userData.uid]];
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
    NSLog(@"PlanViewController=%@",urlString);
    
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
        NSString *webid = [itemDic objectForKey:@"id"];
        NSString *os = [itemDic objectForKey:@"os"];
        NSString *title = [itemDic objectForKey:@"title"];
        
        NSString *url = [NSString stringWithFormat:@"%@/%@.htm?os=%@&uid=%@&id=%@", WEB_URL, action,os,uid,webid];
        NSLog(@"after url = %@",url);
        
        WebViewDetailViewController *planDetailVC = [[WebViewDetailViewController alloc]init];
        planDetailVC.titleName = title;
        planDetailVC.urlName = url;
        
        if (self.top)
        {
            [self.top.navigationController pushViewController:planDetailVC animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:planDetailVC animated:YES];
        }
    }
    
    return YES;
}

@end
