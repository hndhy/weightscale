//
//  CoachViewController.m
//  WeighBean
//
//  Created by heng on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "CoachViewController.h"
#import "LibMacro.h"

#import <RESideMenu.h>

#import "HTTabBarController.h"
#import "ClockInViewController.h"
#import "PlanViewController.h"
#import "CoursesViewController.h"
#import "HTNavigationController.h"
#import "HideSetViewController.h"
//#import "QuestionViewController.h"
#import "QHistoryViewController.h"

@interface CoachViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CoachViewController

- (void)initNavbar
{
    self.title = @"选择战队";
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
//    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [forwardButton setImage:[UIImage imageNamed:@"menu_setting_icon.png"] forState:UIControlStateNormal];
//    [forwardButton addTarget:self action:@selector(onSetingClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] init];
//    space.style = UIBarButtonSystemItemFixedSpace;
//    space.width = 50;
//    self.navigationItem.rightBarButtonItems = @[space,rightItem];
}

- (void)initView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];//SCREEN_HEIGHT_EXCEPTNAVANDTAB
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    HTUserData *userData = [HTUserData sharedInstance];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/vcoach.htm?os=ios&uid=%@", WEB_URL, userData.uid]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self showHUD];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *push = [[NSUserDefaults standardUserDefaults] objectForKey:@"needpushnext"];
    if (push.length)
    {
        HTUserData *user = [HTUserData sharedInstance];
        NSString *tem = [NSString stringWithFormat:@"hyd://www.hyd.com?action=daka_sns&param=self_%@&flash=true",user.uid];
        NSArray *urlComps = [tem componentsSeparatedByString:@"yd://"];
        [self pushNext:urlComps];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"needpushnext"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)onSetingClick
{
    HideSetViewController *hide = [[HideSetViewController alloc] init];
    [self.navigationController pushViewController:hide animated:YES];
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
    NSLog(@"CoachViewController=%@",urlString);
    
    NSArray *urlComps = [urlString componentsSeparatedByString:@"yd://"];
    
    if([urlComps count]>1)
    {
        [self pushNext:urlComps];
        return NO;
    }
    
    return YES;
}

- (void)pushNext:(NSArray *)urlComps
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
    
    //        ClockInViewController *clockInController = [[ClockInViewController alloc] init];
    //        clockInController.actionName = action;
    //        clockInController.clockUid = uid;
    //        [self.navigationController pushViewController:clockInController animated:YES];
    /*
     HTTabBarController *tabBarController = [[HTTabBarController alloc] init];
     ClockInViewController *clockInController = [[ClockInViewController alloc] init];
     clockInController.actionName = action;
     clockInController.clockUid = uid;
     clockInController.top = tabBarController;
     HTNavigationController *clockInNav = [[HTNavigationController alloc] initWithRootViewController:clockInController];
     [tabBarController addViewController:clockInNav];
     CoursesViewController *coursesController = [[CoursesViewController alloc] init];
     coursesController.top = tabBarController;
     HTNavigationController *coursesNav = [[HTNavigationController alloc] initWithRootViewController:coursesController];
     [tabBarController addViewController:coursesNav];
     PlanViewController *planController = [[PlanViewController alloc] init];
     planController.top = tabBarController;
     HTNavigationController *planNav = [[HTNavigationController alloc] initWithRootViewController:planController];
     [tabBarController addViewController:planNav];
     [self.navigationController pushViewController:tabBarController animated:YES];
     
     __weak HTTabBarController *weakTabbar = tabBarController;
     void (^block)(void) = ^{
     weakTabbar.title = @"V教练战队";
     UIButton *refreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0f, 44.0f)];
     [refreButton setImage:[UIImage imageNamed:@"refresh_nav_bar.png"] forState:UIControlStateNormal];
     [refreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
     [refreButton addTarget:clockInController action:@selector(refreshWeb) forControlEvents:UIControlEventTouchUpInside];
     
     UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(44, 0, 40.0f, 44.0f)];
     [questionButton setImage:[UIImage imageNamed:@"question_nav_bar.png"] forState:UIControlStateNormal];
     [questionButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
     [questionButton addTarget:clockInController action:@selector(questionAction) forControlEvents:UIControlEventTouchUpInside];
     
     UIBarButtonItem *refreItem = [[UIBarButtonItem alloc] initWithCustomView:refreButton];
     UIBarButtonItem *questionItem = [[UIBarButtonItem alloc] initWithCustomView:questionButton];
     
     [weakTabbar.navigationItem setRightBarButtonItems:@[questionItem,refreItem]];
     };
     tabBarController.setTopBlock=block;
     [tabBarController showControllerWithTag:1];
     */
    
    
    HTTabBarController *tabBarController = [[HTTabBarController alloc] init];
    
    QHistoryViewController *coursesController = [[QHistoryViewController alloc] init];
    coursesController.isOpenSide = YES;
    coursesController.nav = self.navigationController;
    HTNavigationController *coursesNav = [[HTNavigationController alloc] initWithRootViewController:coursesController];
    [tabBarController addViewController:coursesNav];
    
    ClockInViewController *clockInController = [[ClockInViewController alloc] init];
    HTNavigationController *clockInNav = [[HTNavigationController alloc] initWithRootViewController:clockInController];
    clockInController.actionName = action;
    clockInController.clockUid = uid;
    [tabBarController addViewController:clockInNav];
    
    HideSetViewController *planController = [[HideSetViewController alloc] init];
    HTNavigationController *planNav = [[HTNavigationController alloc] initWithRootViewController:planController];
    [tabBarController addViewController:planNav];
    
    __weak HTTabBarController *weakTabbar = tabBarController;
    void (^block)(void) = ^{
        weakTabbar.title = @"V教练战队";
        UIButton *refreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0f, 44.0f)];
        [refreButton setImage:[UIImage imageNamed:@"refresh_nav_bar.png"] forState:UIControlStateNormal];
        [refreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
        [refreButton addTarget:clockInController action:@selector(refreshWeb) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *refreItem = [[UIBarButtonItem alloc] initWithCustomView:refreButton];
        [weakTabbar.navigationItem setRightBarButtonItems:@[refreItem]];
    };
    tabBarController.setTopBlock=block;
    void (^otherBlock)(void) = ^{
        weakTabbar.title = @"问卷历史";
        UIButton *refreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [refreButton setImage:[UIImage imageNamed:@"add_nav_bar.png"] forState:UIControlStateNormal];
        //            [refreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
        [refreButton addTarget:coursesController action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *refreItem = [[UIBarButtonItem alloc] initWithCustomView:refreButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] init];
        space.width = 40;
        space.style = UIBarButtonSystemItemFixedSpace;
        
        [weakTabbar.navigationItem setRightBarButtonItems:@[space,refreItem]];
    };
    tabBarController.setOtherTopBlock=otherBlock;
    
    [tabBarController showControllerWithTag:1];
    
    [tabBarController setIsCanBackBlock:^BOOL{
        return [coursesController isCanBack];
    }];
    
    [self.navigationController pushViewController:tabBarController animated:YES];
}


@end
