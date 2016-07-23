//
//  LeftMenuViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/8.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "LeftMenuViewController.h"

#import "CommonHelper.h"
#import "MeasureInfoModel.h"

#import "HTNavigationController.h"
#import "MeasureViewController.h"
#import "MyViewController.h"
#import "HomeViewController.h"
#import "DiaryViewController.h"
#import <RESideMenu.h>
#import <UIImageView+WebCache.h>
#import "HTTabBarController.h"
#import "ClockInViewController.h"
#import "PlanViewController.h"
#import "CoursesViewController.h"
#import "CoachViewController.h"
#import "HTZouMaDengModel.h"
#import "ZouMaDengModelHandler.h"
#import "QuestionViewController.h"
#import "WiFiController.h"
#import "ToolsViewController.h"
#import "OnlineBuyViewController.h"
#import "NotifNumberModelHandler.h"
#import "NotifNumberModel.h"
#import "HideSetViewController.h"
#import "QHistoryViewController.h"


@interface LeftMenuViewController ()<PassValueDelegate, ZouMaDengModelProtocol,NotifNumberModelProtocol,RESideMenuDelegate>

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, assign) int index;
@property (nonatomic, strong) HomeViewController *homeController;

@property (nonatomic, strong) HTZouMaDengModel *model;
@property (nonatomic, strong) ZouMaDengModelHandler *handler;

@property (nonatomic, strong) NotifNumberModel *nModel;
@property (nonatomic, strong) NotifNumberModelHandler *nHandler;

@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation LeftMenuViewController

- (void)initModel
{
    self.handler = [[ZouMaDengModelHandler alloc] initWithController:self];
    self.model = [[HTZouMaDengModel alloc] initWithHandler:self.handler];
    
    self.nHandler = [[NotifNumberModelHandler alloc] initWithController:self];
    self.nModel = [[NotifNumberModel alloc] initWithHandler:self.nHandler];
    
//    [self.nModel getNotifNumber];
    
    self.mArray = [NSMutableArray arrayWithCapacity:8];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shake) name:@"shakepushmeasure" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNumber) name:@"changeNotifiNumber" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getServerNumber) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterVCoach) name:@"enterVCoach" object:nil];
}

- (void)initView
{
    self.view.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(27.0f, /*121.0f*/80, 71.0f, 71.0f)];
    self.avatarImageView.backgroundColor = [UIColor whiteColor];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 35.5f;
    self.avatarImageView.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
    self.avatarImageView.layer.borderWidth = 4.0f;
    [self.avatarImageView addTapCallBack:self sel:@selector(onInfoClick:)];
    [self.view addSubview:self.avatarImageView];
    self.nameLabel = [UILabel createLabelWithFrame:CGRectMake(self.avatarImageView.right + 26.0f, 0, 80.0f, 24.0f)
                                        withSize:20.0f withColor:[UIColor whiteColor]];
    self.nameLabel.centerY = self.avatarImageView.centerY;
    [self.nameLabel addTapCallBack:self sel:@selector(onInfoClick:)];
    [self.view addSubview:self.nameLabel];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLabel.right, 0, 21.0f, 21.0f)];
    arrowImageView.centerY = self.nameLabel.centerY;
    arrowImageView.image = [UIImage imageNamed:@"menu_arrow_icon.png"];
    [arrowImageView addTapCallBack:self sel:@selector(onInfoClick:)];
    [self.view addSubview:arrowImageView];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(24.0f, self.avatarImageView.bottom + 30.0f, self.view.width - 24.0f, 0.5f)];
    lineView.backgroundColor = UIColorFromRGB(95.0f, 199.0f, 236.0f);
    [self.view addSubview:lineView];
    UIView *homeView = [self createItem:lineView.bottom icon:@"menu_home_icon.png" title:@"指标首页"];
    [homeView addTapCallBack:self sel:@selector(onHomeClick:)];
    [self.view addSubview:homeView];

    lineView = [[UIView alloc] initWithFrame:CGRectMake(24.0f, homeView.bottom, self.view.width - 24.0f, 1.0f)];
    lineView.backgroundColor = UIColorFromRGB(95.0f, 199.0f, 236.0f);
    [self.view addSubview:lineView];
    UIView *diaryView = [self createItem:lineView.bottom icon:@"menu_diary_icon.png" title:@"生活日记"];
    [diaryView addTapCallBack:self sel:@selector(onDiaryClick:)];
    [self.view addSubview:diaryView];

    lineView = [[UIView alloc] initWithFrame:CGRectMake(24.0f, diaryView.bottom, self.view.width - 24.0f, 1.0f)];
    lineView.backgroundColor = UIColorFromRGB(95.0f, 199.0f, 236.0f);
    [self.view addSubview:lineView];
    UIView *coachView = [self createItem:lineView.bottom icon:@"menu_coach_icon.png" title:@"V身战队"];
    [coachView addTapCallBack:self sel:@selector(onCoachClick:)];
    [self.view addSubview:coachView];
    
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 150, diaryView.bottom + 14,30, 20)];
    _messageLabel.backgroundColor = [UIColor redColor];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.layer.cornerRadius = 10;
    _messageLabel.layer.masksToBounds = YES;
//    _messageLabel.text = @"35";
    _messageLabel.font = [UIFont systemFontOfSize:13];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_messageLabel];
    HTAppContext *us = [HTAppContext sharedContext];
    if (us.messageCount.intValue > 0)
    {
        _messageLabel.text = us.messageCount;
    }
    else
    {
        _messageLabel.text = @"";
        _messageLabel.hidden = YES;
    }
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(24.0f, coachView.bottom, self.view.width - 24.0f, 1.0f)];
    lineView.backgroundColor = UIColorFromRGB(95.0f, 199.0f, 236.0f);
    [self.view addSubview:lineView];
    
    
    UIView *newtoolsView = [self createItem:lineView.bottom icon:@"menu_stat_icon.png" title:@"创星工具"];
    [newtoolsView addTapCallBack:self sel:@selector(onNewtoolClick:)];
    [self.view addSubview:newtoolsView];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(24.0f, newtoolsView.bottom, self.view.width - 24.0f, 1.0f)];
    lineView.backgroundColor = UIColorFromRGB(95.0f, 199.0f, 236.0f);
    [self.view addSubview:lineView];
    UIView *onlineBuyView = [self createItem:lineView.bottom icon:@"menu_buy_icon.png" title:@"在线购买"];
    [onlineBuyView addTapCallBack:self sel:@selector(onOnlineClick:)];
    [self.view addSubview:onlineBuyView];

    UIView *settingView = [self createBottom:36.0f icon:@"menu_setting_icon.png" title:@"设置"];
    [settingView addTapCallBack:self sel:@selector(onSettingClick:)];
    [self.view addSubview:settingView];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(settingView.right, 0, 1.0f, 18.0f)];
    lineView.centerY = settingView.centerY;
    lineView.backgroundColor = UIColorFromRGB(95.0f, 199.0f, 236.0f);
    [self.view addSubview:lineView];
    UIView *measureView = [self createBottom:lineView.right + 27.0f icon:@"menu_measure_icon.png" title:@"测量"];
    [measureView addTapCallBack:self sel:@selector(onMeasureClick:)];
    [self.view addSubview:measureView];
    [self.model getZouMaDeng];
    [NotificationCenter addModifyInfoObserver:self selector:@selector(refreshInfo) object:nil];
    [self refreshInfo];
}

- (void)dealloc
{
  [NotificationCenter removeModifyInfoObserver:self object:nil];
}

- (void)refreshInfo
{
  HTUserData *userData = [HTUserData sharedInstance];
  [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userData.avatar]];
  self.nameLabel.text = userData.nick;
}

- (UIView *)createItem:(CGFloat)top icon:(NSString *)icon title:(NSString *)title
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, top, self.view.width, 48.0f)];
  UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23.0f, 9.0f, 30.0f, 30.0f)];
  iconImageView.image = [UIImage imageNamed:icon];
  [view addSubview:iconImageView];
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(iconImageView.right + 10.0f, 0, 141.0f, 48.0f)
                                        withSize:14.0f withColor:[UIColor whiteColor]];
  label.text = title;
  [view addSubview:label];
  UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(label.right, 0, 21.0f, 21.0f)];
  arrowImageView.centerY = view.height / 2.0f;
  arrowImageView.image = [UIImage imageNamed:@"menu_arrow_icon.png"];
  [view addSubview:arrowImageView];
  return view;
}

- (UIView *)createBottom:(CGFloat)left icon:(NSString *)icon title:(NSString *)title
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(left, self.view.height - 50.0f, 89.0f, 21.0f)];
  UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21.0f, 21.0f)];
  iconImageView.image = [UIImage imageNamed:icon];
  [view addSubview:iconImageView];
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(iconImageView.right + 12.0f, 0,
                                                            view.width - iconImageView.right - 12.0f, 21.0f) withSize:11.0f withColor:[UIColor whiteColor]];
  label.text = title;
    
    if ([title isEqualToString:@"测量"])
    {
        label.textColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
        UIView *layer = [[UIView alloc] init];
        layer.frame = CGRectMake(0, 0, 60, 21);
        layer.backgroundColor = [UIColor whiteColor];
        [view insertSubview:layer belowSubview:iconImageView];
    }
  [view addSubview:label];
  return view;
}

- (void)onInfoClick:(id)sender
{
  if (self.index != 1) {
    MyViewController *myController = [[MyViewController alloc] init];
    HTNavigationController *myNav = [[HTNavigationController alloc] initWithRootViewController:myController];
    [self.sideMenuViewController setContentViewController:myNav animated:YES];
  }
  self.index = 1;
  [self.sideMenuViewController hideMenuViewController];
}

- (void)onHomeClick:(id)sender
{
  self.index = 2;
  self.homeController = [[HomeViewController alloc] init];
  if (self.homeController && IsKindOfClass(sender, NSString)) {
    NSString *value = (NSString *)sender;
    self.homeController.testStr = value;
    MeasureInfoModel *infoMdodel = [CommonHelper parseValue:value];
    NSLog(@"====>weight=%f, bmi=%f, fat=%f, tbw=%f, lbm=%f, bmc=%f, vat=%f, kcal=%d, bodyAge=%d, smr=%f", infoMdodel.weight, infoMdodel.bmi, infoMdodel.fat, infoMdodel.tbw, infoMdodel.lbm, infoMdodel.bmc, infoMdodel.vat, infoMdodel.kcal, infoMdodel.bodyAge,infoMdodel.smr);
    self.homeController.infoModel = infoMdodel;
  }
  HTNavigationController *homeNav = [[HTNavigationController alloc] initWithRootViewController:self.homeController];
  [self.sideMenuViewController setContentViewController:homeNav animated:YES];
  [self.sideMenuViewController hideMenuViewController];
}

- (void)onDiaryClick:(id)sender
{
  if (self.index != 3) {
    DiaryViewController *diaryController = [[DiaryViewController alloc] init];
    HTNavigationController *diaryNav = [[HTNavigationController alloc] initWithRootViewController:diaryController];
    [self.sideMenuViewController setContentViewController:diaryNav animated:YES];
  }
  self.index = 3;
  [self.sideMenuViewController hideMenuViewController];
}

- (void)onCoachClick:(id)sender
{
  if (self.index != 4)
  {
      HTUserData *userData = [HTUserData sharedInstance];
      if (userData.isCoach)
      {
          CoachViewController *coachController = [[CoachViewController alloc]init];
          HTNavigationController *coachNav = [[HTNavigationController alloc] initWithRootViewController:coachController];
          [self.sideMenuViewController setContentViewController:coachNav animated:YES];
      }
      else if (userData.isFresh)
      {
          QuestionViewController *questionController = [[QuestionViewController alloc]init];
          questionController.isOpenSide = YES;
          HTNavigationController *questionNav = [[HTNavigationController alloc] initWithRootViewController:questionController];
          [self.sideMenuViewController setContentViewController:questionNav animated:YES];
          [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"needpushnext"];
          [[NSUserDefaults standardUserDefaults] synchronize];
      }
      else
      {
          HTTabBarController *tabBarController = [[HTTabBarController alloc] init];
          
          QHistoryViewController *coursesController = [[QHistoryViewController alloc] init];
          coursesController.isOpenSide = YES;
          HTNavigationController *coursesNav = [[HTNavigationController alloc] initWithRootViewController:coursesController];
          [tabBarController addViewController:coursesNav];
          
          ClockInViewController *clockInController = [[ClockInViewController alloc] init];
          HTNavigationController *clockInNav = [[HTNavigationController alloc] initWithRootViewController:clockInController];
          [tabBarController addViewController:clockInNav];
          
          HideSetViewController *planController = [[HideSetViewController alloc] init];
          HTNavigationController *planNav = [[HTNavigationController alloc] initWithRootViewController:planController];
          [tabBarController addViewController:planNav];
          [tabBarController showControllerWithTag:1];
          [self.sideMenuViewController setContentViewController:tabBarController animated:YES];
          
          [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"needpushnext"];
          [[NSUserDefaults standardUserDefaults] synchronize];

          
//          HTTabBarController *tabBarController = [[HTTabBarController alloc] init];
//          ClockInViewController *clockInController = [[ClockInViewController alloc] init];
//          HTNavigationController *clockInNav = [[HTNavigationController alloc] initWithRootViewController:clockInController];
//          [tabBarController addViewController:clockInNav];
//          CoursesViewController *coursesController = [[CoursesViewController alloc] init];
//          HTNavigationController *coursesNav = [[HTNavigationController alloc] initWithRootViewController:coursesController];
//          [tabBarController addViewController:coursesNav];
//          PlanViewController *planController = [[PlanViewController alloc] init];
//          HTNavigationController *planNav = [[HTNavigationController alloc] initWithRootViewController:planController];
//          [tabBarController addViewController:planNav];
//          [tabBarController showControllerWithTag:1];
//          [self.sideMenuViewController setContentViewController:tabBarController animated:YES];
          

//          ClockInViewController *clockInController = [[ClockInViewController alloc] init];
//          HTNavigationController *clockInNav = [[HTNavigationController alloc] initWithRootViewController:clockInController];
//          [self.sideMenuViewController setContentViewController:clockInNav animated:YES];
      }
    
  }
  self.index = 4;
  [self.sideMenuViewController hideMenuViewController];
}

- (void)onNewtoolClick:(id)sender
{
    if (self.index != 5)
    {
        ToolsViewController *diaryController = [[ToolsViewController alloc] init];
        HTNavigationController *diaryNav = [[HTNavigationController alloc] initWithRootViewController:diaryController];
        [self.sideMenuViewController setContentViewController:diaryNav animated:YES];
    }
    self.index = 5;
    [self.sideMenuViewController hideMenuViewController];
}

- (void)onOnlineClick:(id)sender
{
    if (self.index != 6)
    {
        OnlineBuyViewController *diaryController = [[OnlineBuyViewController alloc] init];
        HTNavigationController *diaryNav = [[HTNavigationController alloc] initWithRootViewController:diaryController];
        [self.sideMenuViewController setContentViewController:diaryNav animated:YES];
    }
    self.index = 6;
    [self.sideMenuViewController hideMenuViewController];
}

- (void)onSettingClick:(id)sender
{
  [self onInfoClick:sender];
}

- (void)onMeasureClick:(id)sender
{
    HTAppContext *appContext = [HTAppContext sharedContext];
    
    if (ISEMPTY(appContext.device)&& !appContext.isOpenWiFi)
    {
        [self showToast:@"请在个人资料里补填设备号"];
        return;
    }
    NSString *message = !appContext.isOpenWiFi ? @"请您确保手机蓝牙和体脂仪都是开启状态" : @"请您确保手机连接的是秤的WiFi";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:message
                                                 delegate:self
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确定",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex)
    {
        HTAppContext *appContext = [HTAppContext sharedContext];
        if (appContext.isOpenWiFi)
        {
          WiFiController *measureController = [[WiFiController alloc] init];
          measureController.array = self.mArray;
          measureController.delegate = self;
          HTNavigationController *navController = [[HTNavigationController alloc] initWithRootViewController:measureController];
          [self presentViewController:navController animated:YES completion:nil];
        }
        else
        {
          MeasureViewController *measureController = [[MeasureViewController alloc] init];
          measureController.array = self.mArray;
          measureController.delegate = self;
          HTNavigationController *navController = [[HTNavigationController alloc] initWithRootViewController:measureController];
          [self presentViewController:navController animated:YES completion:nil];
        }
    }
}

#pragma mark - PassValueDelegate
- (void)passValue:(id)value type:(int)type
{
  if (1 == type) {
    NSString *result = (NSString *)value;
    [self onHomeClick:result];
    return;
  } else if (3 == type) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"请到设置确认您的设备号"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    return;
  }
  [self.sideMenuViewController hideMenuViewController];
}

#pragma mark - ZouMaDengModelProtocol
- (void)getZouMaDengFinished:(ZouMaDengListResponse *)response
{
    [self.mArray removeAllObjects];
    [self.mArray addObjectsFromArray:response.results];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.mArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"zoumadeng_loading"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)shake
{
    //something happens
    NSString *usermeasure = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermeasureing"];
    
    if ([usermeasure boolValue])
    {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"push" forKey:@"needpushnext"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    /*
    HTAppContext *appContext = [HTAppContext sharedContext];
    
    if (ISEMPTY(appContext.device)&& !appContext.isOpenWiFi)
    {
        [self showToast:@"请在个人资料里补填设备号"];
        return;
    }
    if (appContext.isOpenWiFi)
    {
        WiFiController *measureController = [[WiFiController alloc] init];
        measureController.array = self.mArray;
        measureController.delegate = self;
        HTNavigationController *navController = [[HTNavigationController alloc] initWithRootViewController:measureController];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else
    {
        MeasureViewController *measureController = [[MeasureViewController alloc] init];
        measureController.array = self.mArray;
        measureController.delegate = self;
        HTNavigationController *navController = [[HTNavigationController alloc] initWithRootViewController:measureController];
        [self presentViewController:navController animated:YES completion:nil];
    }
     */
    [self onCoachClick:nil];
    
}

- (void)syncFinished:(NotifNumberResponse *)response;
{
    HTAppContext *cont = [HTAppContext sharedContext];
    
    cont.messageCount = response.number.description;
    [cont save];
    
    if (cont.messageCount.integerValue > 0)
    {
        _messageLabel.text = cont.messageCount;
        _messageLabel.hidden = NO;
    }
    else
    {
        _messageLabel.hidden = YES;
    }
}

- (void)syncFailure
{
    
}

- (void)changeNumber
{
    NSInteger msgcount = [HTAppContext sharedContext].messageCount.integerValue;
    if (msgcount > 0)
    {
        _messageLabel.text = [HTAppContext sharedContext].messageCount;
        _messageLabel.hidden = NO;
    }
    else
    {
        _messageLabel.hidden = YES;
    }
}

- (void)getServerNumber
{
//    [self.nModel getNotifNumber];
}

- (void)enterVCoach
{
    self.index = -1;
    [self onCoachClick:nil];
}

@end
