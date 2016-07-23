//
//  ClockInViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/11.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "ClockInViewController.h"
#import "PicturePicker.h"
#import "LibMacro.h"
#import "UploadAvatarModelHandler.h"
#import "UpLoadAvatarModel.h"
#import <RESideMenu.h>
#import "QuestionViewController.h"
#import "WebViewDetailViewController.h"

@interface ClockInViewController ()<UIWebViewDelegate,PicturePickerProtocol,UploadAvatarModelProtocol>

@property (nonatomic, strong) UpLoadAvatarModel *upLoadAvatarModel;
@property (nonatomic, strong) UploadAvatarModelHandler *uploadAvatarModelHandler;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) PicturePicker *picturePicker;
@property (nonatomic, strong) NSString *clickTag;

@end

@implementation ClockInViewController


-(void)initModel
{
    self.uploadAvatarModelHandler = [[UploadAvatarModelHandler alloc] initWithController:self];
    self.upLoadAvatarModel = [[UpLoadAvatarModel alloc] initWithHandler:self.uploadAvatarModelHandler];
}
- (void)initNavbar
{
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        
    HTUserData *userData = [HTUserData sharedInstance];
    self.title = @"V教练战队";

    self.actionName = @"daka_sns";

    self.clockUid = self.clockUid.length ? self.clockUid : userData.uid;
    
    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *refreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0f, 44.0f)];
    [refreButton setImage:[UIImage imageNamed:@"refresh_nav_bar.png"] forState:UIControlStateNormal];
    [refreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
    [refreButton addTarget:self action:@selector(refreshWeb) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(44, 0, 40.0f, 44.0f)];
//    [questionButton setImage:[UIImage imageNamed:@"question_nav_bar.png"] forState:UIControlStateNormal];
//    [questionButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
//    [questionButton addTarget:self action:@selector(questionAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *refreItem = [[UIBarButtonItem alloc] initWithCustomView:refreButton];
//    UIBarButtonItem *questionItem = [[UIBarButtonItem alloc] initWithCustomView:questionButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] init];
    space.style =UIBarButtonSystemItemFixedSpace;
    space.width = 20;
    [self.navigationItem setRightBarButtonItems:@[refreItem]];
}

- (void)initView
{
  self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT_EXCEPTNAVANDTAB)];
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
  self.webView.delegate = self;
  [self.view addSubview:self.webView];
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@.htm?os=ios&uid=%@", WEB_URL,self.actionName, self.clockUid]];
  self.request = [[NSURLRequest alloc] initWithURL:url];
  [self.webView loadRequest:self.request];
  [self showHUD];
    
    [HTAppContext sharedContext].messageCount = @"0";
    [[HTAppContext sharedContext] save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNotifiNumber" object:nil];
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
    //拦截到ur之后，选择照片上传，然后刷新页面
    //hyd://www.hyd.com?action=uploadPaizhao&param=jiacan&flash=true
    if ([urlString containsString:@"param=xunlian"]) {
        self.clickTag = @"训练";
        
        [self updatePhoto];
        return NO;
    }else if ([urlString containsString:@"param=jiacan"]){
        self.clickTag = @"加餐";
        [self updatePhoto];
        return NO;
    }
    
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
        
        NSString *uid = [itemDic objectForKey:@"uid"];
        NSString *title = [itemDic objectForKey:@"nick"];

        NSString *url = [NSString stringWithFormat:@"%@/%@.htm?os=ios&uid=%@", WEB_URL, action,uid];
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
        return NO;
    }
    return YES;
}

-(void)updatePhoto
{
    if (nil == self.picturePicker) {
        self.picturePicker = [[PicturePicker alloc] initWithController:self];
        self.picturePicker.type = PicturePickerAvatar;
    }
    [self.picturePicker showActionSheet:nil];
}

- (void)selectImage:(UIImage *)image
{
    [self showHUDWithLabel:@"正在上传照片..."];
    [self.upLoadAvatarModel uploadPhotoWithImage:image tag:self.clickTag];
}

- (void)uploadAvatarFinished:(UploadAvatarResponse *)response{
     [self.webView loadRequest:self.request];
}

- (void)refreshWeb
{
    [self showHUD];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@.htm?os=ios&uid=%@", WEB_URL,self.actionName, self.clockUid]];
    self.request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:self.request];
}

- (void)questionAction
{
    QuestionViewController *que = [[QuestionViewController alloc] init];
    if (self.top)
    {
        [self.top.navigationController pushViewController:que animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:que animated:YES];
    }
}

@end
