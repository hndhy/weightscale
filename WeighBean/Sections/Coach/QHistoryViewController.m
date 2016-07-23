//
//  QHistoryViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/12.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "QHistoryViewController.h"
#import "LibMacro.h"
#import <RESideMenu.h>
#import "HTTabBarController.h"
#import "ClockInViewController.h"
#import "PlanViewController.h"
#import "CoursesViewController.h"
#import "HTNavigationController.h"
#import "WebViewDetailViewController.h"
#import "QuestionViewController.h"

@interface QHistoryViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation QHistoryViewController

- (void)initNavbar
{
    self.title = @"历史问卷";
    
    if (self.isOpenSide)
    {
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(leftBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [forwardButton setImage:[UIImage imageNamed:@"add_nav_bar"] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] init];
    space.style =UIBarButtonSystemItemFixedSpace;
    space.width = 20;
    self.navigationItem.rightBarButtonItems = @[space,rightItem];
}

- (void)leftBack
{
    if ([self isCanBack])
    {
        [self presentLeftMenuViewController:nil];
    }
}


- (BOOL)isCanBack
{
    if (self.webView.canGoBack)
    {
        [self.webView goBack];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)initView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT_EXCEPTNAV)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    HTUserData *userData = [HTUserData sharedInstance];
    // wenjuan.htm
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/wenjuanHistory.htm?os=ios&uid=%@", WEB_URL, userData.uid]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self showHUD];
}

- (void)onAddClick
{
    QuestionViewController *planDetailVC = [[QuestionViewController alloc]init];
    if (self.nav)
    {
        [self.nav pushViewController:planDetailVC animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:planDetailVC animated:YES];
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHUD];
    if (webView.canGoBack)
    {
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [menuButton setImage:[UIImage imageNamed:@"black_nav_bar.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(leftBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    else
    {
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(leftBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlString=%@",urlString);
    NSArray *urlComps = [urlString componentsSeparatedByString:@"yd://"];
    if([urlComps count]>1)
    {
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@"?"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:1];
        NSArray *parms=  [funcStr componentsSeparatedByString:@"&"];
        NSMutableDictionary *itemDic=[[NSMutableDictionary alloc]init];
        for (NSString *str  in parms)
        {
            NSArray *item=[str componentsSeparatedByString:@"="];
            [itemDic setObject:item[1] forKey:item[0]];
        }
        NSLog(@"action = %@",[itemDic objectForKey:@"action"]);
        NSString *action = [itemDic objectForKey:@"action"];
        if ([action isEqualToString:@"gobackapp"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }
        NSString *param = [itemDic objectForKey:@"param"];
        NSString *title = [itemDic objectForKey:@"title"];
        HTUserData *userData = [HTUserData sharedInstance];
        [userData save];
        NSString *url = [NSString stringWithFormat:@"%@/%@.htm?param=%@&os=ios&uid=%@", WEB_URL, action,param,userData.uid];
        NSLog(@"after url = %@",url);
        
        WebViewDetailViewController *planDetailVC = [[WebViewDetailViewController alloc]init];
        planDetailVC.titleName = title;
        planDetailVC.urlName = url;
        if (self.nav)
        {
            [self.nav pushViewController:planDetailVC animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:planDetailVC animated:YES];
        }
        return NO;
    }
    return YES;
}

@end
