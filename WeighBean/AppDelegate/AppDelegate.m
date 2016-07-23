//
//  AppDelegate.m
//  WeighBean
//
//  Created by liumadu on 15/7/27.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "AppDelegate.h"

#import "IndexViewController.h"
#import "HTNavigationController.h"
#import "LeftMenuViewController.h"
#import "HomeViewController.h"
#import <RESideMenu.h>
#import "DBHelper.h"
#import "HTAppContext.h"
#import "Reachability.h"

#import "LibMacro.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"

#import "MobClick.h"
#import "UILabel+Ext.h"
#import "WXThrid.h"
#import "MiPushSDK.h"

@interface AppDelegate ()<MiPushSDKDelegate>

@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic, strong) NSMutableDictionary *updateInfo;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Init Network Reachability
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [DBHelper getUsingLKDBHelper];
    //sharesdk
    [ShareSDK registerApp:SHARESDK_KEY];
    [ShareSDK connectWeChatWithAppId:WECHAT_APPKEY appSecret:WECHAT_SECRET wechatCls:[WXApi class]];
    [ShareSDK connectSMS];

    HTAppContext *appContext = [HTAppContext sharedContext];
//#warning 打包时要修改
    appContext.isOpenWiFi = NO;//是否是WIFI或蓝牙
    [appContext saveIsOpen];
    if (ISEMPTY(appContext.uid) || [@"-1" isEqualToString:appContext.uid])
    {
        [self showIndexView];
    }
    else
    {
        [self showHomeView];
    }
    self.updateInfo = [[NSMutableDictionary alloc] init];
    [self setUM];
    
    // IOS8 新系统需要使用新的代码咯
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    [MiPushSDK registerMiPush:self type:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) connect:YES];
    
    NSString *number = [NSString stringWithFormat:@"%d",[UIApplication sharedApplication].applicationIconBadgeNumber];
    [HTAppContext sharedContext].messageCount = number;
    [[HTAppContext sharedContext] save];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNotifiNumber" object:nil];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
  return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [WXThrid handleWXThridURL:url];
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0f)
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    NSInteger msgcount = [HTAppContext sharedContext].messageCount.integerValue;
    [UIApplication sharedApplication].applicationIconBadgeNumber = msgcount;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSString *number = [NSString stringWithFormat:@"%d",[UIApplication sharedApplication].applicationIconBadgeNumber];
    [HTAppContext sharedContext].messageCount = number;
    [[HTAppContext sharedContext] save];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNotifiNumber" object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Local And Push Notification
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@",[NSString stringWithFormat:@"APNS token: %@", [deviceToken description]]);
    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"push注册失败: %@",[NSString stringWithFormat:@"APNS error: %@", err]);
    // 注册APNS失败.
    // 自行处理.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"push注册成功: %@",[NSString stringWithFormat:@"APNS notify: %@", userInfo]);
    
    // 当同时启动APNs与内部长连接时, 把两处收到的消息合并. 通过miPushReceiveNotification返回
    [MiPushSDK handleReceiveRemoteNotification:userInfo];
}

#pragma mark MiPushSDKDelegate
- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data
{
    NSLog(@"收到小米Push成功: %@",[NSString stringWithFormat:@"command succ(%@): %@", [self getOperateType:selector], data]);
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data
{
    NSLog(@"收到小米Push失败:%@",[NSString stringWithFormat:@"command error(%d|%@): %@", error, [self getOperateType:selector], data]);
}

- (void)miPushReceiveNotification:(NSDictionary*)data
{
    // 1.当启动长连接时, 收到消息会回调此处
    // 2.[MiPushSDK handleReceiveRemoteNotification]
    //   当使用此方法后会把APNs消息导入到此
    NSLog(@"%@",[NSString stringWithFormat:@"XMPP notify: %@", data]);
    
    NSDictionary *aps = data[@"aps"];
    if (aps && [aps isKindOfClass:[NSDictionary class]]) {
        NSString *str = [aps[@"badge"] description];
        if (str && [str isKindOfClass:[NSString class]])
        {
            [HTAppContext sharedContext].messageCount=str;
            [[HTAppContext sharedContext] save];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNotifiNumber" object:nil];
        }
    }
}

- (NSString*)getOperateType:(NSString*)selector
{
    NSString *ret = nil;
    if ([selector hasPrefix:@"registerMiPush:"] ) {
        ret = @"客户端注册设备";
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
        ret = @"客户端设备注销";
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
        ret = @"绑定 PushDeviceToken";
    }else if ([selector isEqualToString:@"setAlias:"]) {
        ret = @"客户端设置别名";
    }else if ([selector isEqualToString:@"unsetAlias:"]) {
        ret = @"客户端取消别名";
    }else if ([selector isEqualToString:@"subscribe:"]) {
        ret = @"客户端设置主题";
    }else if ([selector isEqualToString:@"unsubscribe:"]) {
        ret = @"客户端取消主题";
    }else if ([selector isEqualToString:@"setAccount:"]) {
        ret = @"客户端设置账号";
    }else if ([selector isEqualToString:@"unsetAccount:"]) {
        ret = @"客户端取消账号";
    }else if ([selector isEqualToString:@"openAppNotify:"]) {
        ret = @"统计客户端";
    }else if ([selector isEqualToString:@"getAllAliasAsync"]) {
        ret = @"获取Alias设置信息";
    }else if ([selector isEqualToString:@"getAllTopicAsync"]) {
        ret = @"获取Topic设置信息";
    }
    
    return ret;
}


- (void)showIndexView {
  IndexViewController *controller = [[IndexViewController alloc] init];
  controller.hiddenNavigationBar = YES;
  HTNavigationController *navController = [[HTNavigationController alloc] initWithRootViewController:controller];
  self.window.rootViewController = navController;
  [self.window makeKeyAndVisible];
}

- (void)showHomeView {
  HomeViewController *homeController = [[HomeViewController alloc] init];
  HTNavigationController *homeNav = [[HTNavigationController alloc] initWithRootViewController:homeController];
  LeftMenuViewController *leftMenuController = [[LeftMenuViewController alloc] init];
  RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:homeNav
                                                    leftMenuViewController:leftMenuController
                                                   rightMenuViewController:nil];
  sideMenu.panGestureEnabled = NO;
  sideMenu.parallaxEnabled = NO;
  sideMenu.interactivePopGestureRecognizerEnabled = NO;
  sideMenu.panFromEdge = NO;
  self.window.rootViewController = sideMenu;
  [self.window makeKeyAndVisible];
    
    if ([HTUserData sharedInstance].uid.length)
    {
        [MiPushSDK setAlias:[HTUserData sharedInstance].uid];
    }
}

- (void)setUM
{
    [MobClick startWithAppkey:UMENG_APPKEY];
//    [MobClick checkUpdate];
//    [MobClick checkUpdate:@"发现新版本" cancelButtonTitle:@"以后再说" otherButtonTitles:@"立即更新"];
//    [MobClick checkUpdateWithDelegate:self selector:@selector(updateInfo:)];
}

- (void)updateInfo:(NSDictionary *)dic
{
    if (dic && [dic isKindOfClass:[NSDictionary class]])
    {
        [self.updateInfo setDictionary:dic];
        NSString *message = dic[@"update_log"];
        NSString *path = dic[@"path"];
        BOOL isUpdate = [dic[@"update"] boolValue];
        BOOL isValidMessage = message &&[message isKindOfClass:[NSString class]]&& message.length;
        BOOL isValidPath = path &&[path isKindOfClass:[NSString class]]&& path.length;
        if (isUpdate && isValidMessage && isValidPath)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:message delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"立即更新", nil];
            alert.tag = 0xfbc;
            [alert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *path = self.updateInfo[@"path"];
    if (alertView.tag == 0xfbc && buttonIndex != alertView.cancelButtonIndex)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    for( UIView * view in alertView.subviews )
    {
        if( [view isKindOfClass:[UILabel class]] )
        {
            UILabel* label = (UILabel*) view;
            label.textAlignment =  NSTextAlignmentLeft;
        }
    }
}


@end
