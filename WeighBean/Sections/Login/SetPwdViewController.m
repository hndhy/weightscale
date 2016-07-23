//
//  SetPwdViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "SetPwdViewController.h"

#import "HTFindPwdModel.h"
#import "FindPwdModelHandler.h"
#import "AccountData.h"
#import "DBHelper.h"
#import "AppDelegate.h"

@interface SetPwdViewController ()<FindPwdModelProtocol>

@property (nonatomic, strong) HTTextField *pwdTextField;
@property (nonatomic, strong) HTTextField *rePwdTextField;

@property (nonatomic, strong) HTFindPwdModel *findPwdModel;
@property (nonatomic, strong) FindPwdModelHandler *findPwdModelHandler;

@end

@implementation SetPwdViewController

- (void)initNavbar
{
  self.title = @"重置密码";
}

- (void)initModel
{
  self.findPwdModelHandler = [[FindPwdModelHandler alloc] initWithController:self];
  self.findPwdModel = [[HTFindPwdModel alloc] initWithHandler:self.findPwdModelHandler];
}

- (void)initView
{
  [self.view addTapCallBack:self sel:@selector(didTapAnywhere:)];
  UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(26.0f, 47.0f, self.view.width - 52.0f, 38.0f)];
  pwdView.layer.cornerRadius = 4.0f;
  pwdView.layer.masksToBounds = YES;
  pwdView.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  pwdView.layer.borderWidth = 0.5f;
  pwdView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:pwdView];
  self.pwdTextField = [[HTTextField alloc] initWithFrame:CGRectMake(pwdView.left + 10.0f, pwdView.top, pwdView.width - 10.0f, pwdView.height)];
  self.pwdTextField.hint = @"请输入新密码";
  self.pwdTextField.textColor = [UIColor blackColor];
  self.pwdTextField.secureTextEntry = YES;
  [self.view addSubview:self.pwdTextField];
  UIView *rePwdView = [[UIView alloc] initWithFrame:CGRectMake(26.0f, pwdView.bottom + 9.0f, self.view.width - 52.0f, 38.0f)];
  rePwdView.layer.cornerRadius = 4.0f;
  rePwdView.layer.masksToBounds = YES;
  rePwdView.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  rePwdView.layer.borderWidth = 0.5f;
  rePwdView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:rePwdView];
  self.rePwdTextField = [[HTTextField alloc] initWithFrame:CGRectMake(rePwdView.left + 10.0f, rePwdView.top, rePwdView.width - 10.0f, rePwdView.height)];
  self.rePwdTextField.hint = @"请再次输入密码";
  self.rePwdTextField.textColor = [UIColor blackColor];
  self.rePwdTextField.secureTextEntry = YES;
  [self.view addSubview:self.rePwdTextField];
  UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, rePwdView.bottom + 32.0f, 290.0f, 37.0f)];
  submitButton.centerX = self.view.centerX;
  [submitButton setBackgroundImage:[UIImage imageNamed:@"login_normal.png"] forState:UIControlStateNormal];
  submitButton.tintColor = [UIColor whiteColor];
  submitButton.titleLabel.font = UIFontOfSize(16.0f);
  [submitButton setTitle:@"确认" forState:UIControlStateNormal];
  [submitButton addTarget:self action:@selector(onSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:submitButton];
}

- (void)onSubmitClick:(id)sender
{
  NSString *pwd = self.pwdTextField.textValue;
  if (ISEMPTY(pwd)) {
    [self showToast:@"请输入新密码"];
    return;
  }
  NSString *rePwd = self.rePwdTextField.textValue;
  if (ISEMPTY(rePwd)) {
    [self showToast:@"请再次输入密码"];
    return;
  }
  if (![pwd isEqualToString:rePwd]) {
    [self showToast:@"两次输入的密码不一致，请重新确认"];
    return;
  }
  [self showHUDWithLabel:@"正在提交信息"];
  [self.findPwdModel findPwdWithPhone:self.phone code:self.qcode pwd:pwd];
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer
{
  if (self.pwdTextField.isFirstResponder) {
    [self.pwdTextField resignFirstResponder];
  }
  if (self.rePwdTextField.isFirstResponder) {
    [self.rePwdTextField resignFirstResponder];
  }
}

#pragma mark - FindPwdModelProtocol
- (void)findPwdFinished:(UserResponse *)response
{
    HTAppContext *appContext = [HTAppContext sharedContext];
    appContext.uid = response.uid;
    [appContext save];
    HTUserData *userData = [HTUserData sharedInstance];
    userData.isFresh = response.isFresh;
    userData.age = response.age;
    userData.avatar = response.avatar;
    userData.birthday = response.birthday;
    userData.coachTel = response.coachTel;
    //  userData.device = response.device;
    userData.height = response.height;
    userData.isCoach = response.isCoach;
    userData.nick = response.nick;
    userData.sex = response.sex;
    userData.tel = response.tel;
    userData.uid = response.uid;
    [userData save];
    
    NSString *pwd = self.pwdTextField.textValue;
    AccountData *accountData = [[AccountData alloc]init];
    accountData.avatar = response.avatar;
    accountData.pwd = pwd;
    accountData.loginTime = [[NSDate date] timeIntervalSince1970];
    LKDBHelper *lkdbHelper = [DBHelper getUsingLKDBHelper];
    [lkdbHelper deleteWithClass:[AccountData class] where:[NSString stringWithFormat:@"avatar=%@",response.avatar] callback:^(BOOL result) {
        
        [lkdbHelper insertToDB:accountData];
    }];
    
  [APP_DELEGATE showHomeView];
}

@end
