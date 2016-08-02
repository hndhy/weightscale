//
//  QuestionViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/9/2.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "QuestionViewController.h"
#import "LibMacro.h"
#import <RESideMenu.h>
#import "HTTabBarController.h"
#import "ClockInViewController.h"
#import "PlanViewController.h"
#import "CoursesViewController.h"
#import "HTNavigationController.h"
#import "WebViewDetailViewController.h"
#import "HTMyInfoModel.h"
#import "MyInfoModelHandler.h"

@interface QuestionViewController ()<UIWebViewDelegate,MyInfoModelProtocol>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) HTMyInfoModel *myInfoModel;
@property (nonatomic, strong) MyInfoModelHandler *myInfoModelHandler;

@end

@implementation QuestionViewController

- (void)initModel
{
    self.myInfoModelHandler = [[MyInfoModelHandler alloc] initWithController:self];
    self.myInfoModel = [[HTMyInfoModel alloc] initWithHandler:self.myInfoModelHandler];
}

- (void)initNavbar
{
    self.title = @"问卷";

    if (self.isOpenSide)
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
    HTUserData *userData = [HTUserData sharedInstance];
    // wenjuan.htm
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/wenjuan.htm?os=ios&uid=%@", WEB_URL, userData.uid]];
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
        [self.navigationController pushViewController:planDetailVC animated:YES];
        
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.myInfoModel getMyInfo:userData.uid];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/wenjuan.htm?os=ios&uid=%@", WEB_URL, userData.uid]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            [weakSelf.webView loadRequest:request];
        });
        
        return NO;
    }
    return YES;
}

- (void)myInfoFinished:(UserResponse *)response;
{
    HTUserData *data = [HTUserData sharedInstance];
//    data.isFresh = response.isFresh;
    [data save];
}

@end
