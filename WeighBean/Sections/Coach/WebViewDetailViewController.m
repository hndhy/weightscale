//
//  PlanDetailViewController.m
//  WeighBean
//
//  Created by heng on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "WebViewDetailViewController.h"
#import "LibMacro.h"
#import "TrendListViewController.h"
#import <RESideMenu.h>
#import "SharePlat.h"
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>

@interface WebViewDetailViewController ()<UIWebViewDelegate,SharePlatDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) SharePlat *sharePlat;

@end

@implementation WebViewDetailViewController

- (void)initNavbar
{
    self.title = self.titleName;
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [menuButton setImage:[UIImage imageNamed:@"black_nav_bar.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(leftBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    if (_isOutNav)
    {
        NSString *name = @"home_forward_icon";
        if ([self.titleName rangeOfString:@"开单历史"].length)
        {
            name = @"add_nav_bar";
        }
        UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [forwardButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [forwardButton addTarget:self action:@selector(onForwardClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    if ([self.titleName rangeOfString:@"身体状况总结"].length)
    {
        NSString *name = @"nav_info";
        UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [forwardButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [forwardButton addTarget:self action:@selector(onJianyiClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    if (self.otherUid)
    {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [button setImage:[UIImage imageNamed:@"body_trend"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onTrendClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] init];
        space.style =UIBarButtonSystemItemFixedSpace;
        space.width = 50;
        
        self.navigationItem.rightBarButtonItems = @[space,rightItem];
    }
}

- (void)leftBack
{
    if ([self.titleName isEqualToString:@"教练建议"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSArray *array = @[@"mb_aizhengnan.htm",
                       @"mb_aizhengnv.htm",
                       @"mb_shenbing.htm",
                       @"mb_tangniaobing.htm",
                       @"mb_xinxueguan.htm",
                       @"mb_xueshuan.htm",
                       @"mb_zhongfeng.htm"];
    BOOL hasSpecail = NO;
    for (NSString *one in array)
    {
        if ([self.webView.request.URL.absoluteString rangeOfString:one].length)
        {
            hasSpecail = YES;
        }
    }
    if (hasSpecail)
    {
        [self.webView goBack];
        [self.webView goBack];
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.webView reload];
        });
        return;
    }
    
    if (self.webView.canGoBack&&![self.titleName isEqualToString:@"询问开单"])
    {
        [self.webView goBack];
    }
    else
    {
        [self onBackViewController:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.titleName isEqualToString:@"开单历史"])
    {
        [self.webView reload];
    }
}

- (void)initView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT_EXCEPTNAV)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:self.urlName];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self showHUD];
    
    if ([self.urlName rangeOfString:@"fits_program.htm"].length)
    {
        [self setRight];
        self.title = @"瘦身方案";
    }
    
    self.sharePlat = [SharePlat sharedInstance];
    self.sharePlat.delegate = self;
}

- (void)setRight
{
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [nextButton setImage:[UIImage imageNamed:@"next_nav_bar.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)onNextClick
{
    HTUserData *userData = [HTUserData sharedInstance];
    if (userData.isCoach)
    {
        if (self.navigationController.viewControllers.count > 1)
        {
            UIViewController *vc = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enterVCoach" object:nil];
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHUD];
    
    if ([self.titleName isEqualToString:@"慢病预测"])
    {
        if (webView.canGoBack)
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        else
        {
            NSString *name = @"home_forward_icon";
            UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
            [forwardButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
            [forwardButton addTarget:self action:@selector(onForwardClick:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
            self.navigationItem.rightBarButtonItem = rightItem;
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"PlanViewController=%@",urlString);
    if ([urlString rangeOfString:@"wenjuanKaidanAnalysis.htm"].length &&
        ![self.urlName rangeOfString:@"wenjuanKaidanAnalysis.htm"].length)
    {
        NSString *wid = @"";
        NSRange range = [urlString rangeOfString:@"wid="];
        if (range.length && urlString.length >= range.length + range.location)
        {
            wid = [urlString substringFromIndex:range.length + range.location];
        }
        
        WebViewDetailViewController *planDetailVC = [[WebViewDetailViewController alloc]init];
        planDetailVC.titleName = @"身体状况总结";
        planDetailVC.urlName = urlString;
        planDetailVC.wid = wid;
        [self.navigationController pushViewController:planDetailVC animated:YES];
        return NO;
    }
    
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
        if ([action isEqualToString:@"gowendaKaidanHistory"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }
        NSString *uid = [itemDic objectForKey:@"uid"];
        NSString *webid = [itemDic objectForKey:@"id"];
        NSString *os = [itemDic objectForKey:@"os"];
        NSString *title = [itemDic objectForKey:@"title"];
        NSString *param = [itemDic objectForKey:@"param"];
        NSString *url = [NSString stringWithFormat:@"%@/%@.htm?os=%@&uid=%@&id=%@param=%@", WEB_URL, action,os,uid,webid,param];
        NSLog(@"after url = %@",url);
        
        WebViewDetailViewController *planDetailVC = [[WebViewDetailViewController alloc]init];
        planDetailVC.titleName = title;
        planDetailVC.urlName = url;
        [self.navigationController pushViewController:planDetailVC animated:YES];
        return NO;
    }
    
    return YES;
}

- (void)onForwardClick:(id)sender
{
    if ([self.titleName rangeOfString:@"开单历史"].length)
    {
        HTUserData *userData = [HTUserData sharedInstance];
        NSString *url = [NSString stringWithFormat:@"%@/wenjuanKaidan.htm?os=ios&uid=%@", WEB_URL,userData.uid];
        NSLog(@"after url = %@",url);
        WebViewDetailViewController *planDetailVC = [[WebViewDetailViewController alloc]init];
        planDetailVC.titleName = @"询问开单";
        planDetailVC.urlName = url;
        [self.navigationController pushViewController:planDetailVC animated:YES];
    }
    else
    {
        self.sharePlat.showTrend = NO;
        [self.sharePlat showShareActionSheet];
        self.sharePlat.delegate = self;
    }
}

- (void)onTrendClick
{
    TrendListViewController *trendController = [[TrendListViewController alloc] init];
    trendController.otherUid = _otherUid;
    trendController.nickName = self.titleName;
    [self.navigationController pushViewController:trendController animated:YES];
}

- (void)onJianyiClick
{
    HTUserData *userData = [HTUserData sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@wenjuanKaidanCommentViewOrEdit.htm?os=ios&uid=%@&wid=%@", WEB_URL,userData.uid,self.wid];
    NSLog(@"after url = %@",url);
    WebViewDetailViewController *planDetailVC = [[WebViewDetailViewController alloc]init];
    planDetailVC.titleName = @"教练建议";
    planDetailVC.urlName = url;
    planDetailVC.isOutNav = YES;
    [self.navigationController pushViewController:planDetailVC animated:YES];
}

- (void)gotoTrend
{
    
}

- (void)sendSMS:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    BOOL didAttachImage = [picker addAttachmentData:imageData typeIdentifier:@"image/png" filename:@"image.png"];
    if (didAttachImage) {
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                               message:@"您的手机不支持发送图片功能"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
        [warningAlert show];
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (MessageComposeResultCancelled == result) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
