//
//  LoginViewController.m
//  Here
//
//  Created by liumadu on 15-1-6.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "LoginViewController.h"

#import "UIImage+Ext.h"
#import "NSString+Additions.h"
#import "AccountData.h"
#import "HTLoginModel.h"
#import "LoginModelHandler.h"
#import "LKDBHelper.h"
#import "DBHelper.h"
#import "AppDelegate.h"
#import "HTBaseCell.h"
#import "ForgetPwdViewController.h"

@interface LoginViewController ()<LoginModelProtocol,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) HTTextField *nameTextField;
@property (nonatomic, strong) HTTextField *pwdTextField;
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UITableView *accTableView;

@property (nonatomic, strong) NSArray *accArray;
@property (nonatomic, strong) HTLoginModel *loginModel;
@property (nonatomic, strong) LoginModelHandler *loginModelHandler;

@end

@implementation LoginViewController

- (void)initNavbar
{
  self.title = @"登录";
  UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
  [backButton setImage:[UIImage imageNamed:@"close_nav_bar.png"] forState:UIControlStateNormal];
  [backButton addTarget:self action:@selector(onBackViewController:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
  self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initModel
{
  self.accArray = [[NSArray alloc]init];
  self.loginModelHandler = [[LoginModelHandler alloc] initWithController:self];
  self.loginModel = [[HTLoginModel alloc] initWithHandler:self.loginModelHandler];
}

- (void)initView
{
  UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
  oneTap.delegate = self;
  oneTap.numberOfTouchesRequired = 1;
  [self.view addGestureRecognizer:oneTap];
  
  UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(15.0f, 45.0f, 32.0f, 38.0f) withSize:16.0f withColor:[UIColor blackColor]];
  nameLabel.text = @"帐号";
  [self.view addSubview:nameLabel];
  UIView *nameLine = [[UIView alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom, self.view.width - 30.0f, 1.0f)];
  nameLine.backgroundColor = UIColorFromRGB(210.0f, 210.0f, 210.0f);
  [self.view addSubview:nameLine];
  self.nameTextField = [[HTTextField alloc] initWithFrame:CGRectMake(nameLabel.right + 30.0f, nameLabel.top,
                                                                     nameLine.width - nameLabel.width - 60.0f, nameLabel.height)];
  self.nameTextField.hintColor = UIColorFromRGB(216.0f, 216.0f, 216.0f);
  self.nameTextField.hint = @"请输入手机号或用户名";
//  self.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
  self.nameTextField.textColor = [UIColor blackColor];
  self.nameTextField.delegate = self;
  [self.view addSubview:self.nameTextField];
  
  UIButton *accButton = [UIButton buttonWithType:UIButtonTypeCustom];
  accButton.frame = CGRectMake(self.nameTextField.right, self.nameTextField.top, 34, 34);
  [accButton addTarget:self action:@selector(onAccClick) forControlEvents:UIControlEventTouchUpInside];
  [accButton setImage:[UIImage imageNamed:@"login_arrow_icon_1.png"] forState:UIControlStateNormal];
  [self.view addSubview:accButton];
  //账号列表
  self.accTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.nameTextField.left, self.nameTextField.bottom, self.nameTextField.width, 60) style:UITableViewStylePlain];
  self.accTableView.backgroundColor = [UIColor clearColor];
  self.accTableView.delegate = self;
  self.accTableView.dataSource = self;
  self.accTableView.hidden = YES;
  [self.view addSubview:self.accTableView];
  
  self.secondView = [[UIView alloc]initWithFrame:CGRectMake(0, self.nameTextField.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.nameTextField.bottom)];
  
  self.secondView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:self.secondView];
  
  UILabel *pwdLabel = [UILabel createLabelWithFrame:CGRectMake(15.0f, 15.0f, 32.0f, 38.0f)
                                           withSize:16.0f withColor:[UIColor blackColor]];
  pwdLabel.text = @"密码";
  [self.secondView addSubview:pwdLabel];
  UIView *pwdLine = [[UIView alloc] initWithFrame:CGRectMake(pwdLabel.left, pwdLabel.bottom, self.view.width - 30.0f, 1.0f)];
  pwdLine.backgroundColor = UIColorFromRGB(210.0f, 210.0f, 210.0f);
  [self.secondView addSubview:pwdLine];
  self.pwdTextField = [[HTTextField alloc] initWithFrame:CGRectMake(pwdLabel.right + 30.0f, pwdLabel.top,
                                                                    pwdLine.width - pwdLabel.width - 30.0f, pwdLabel.height)];
  self.pwdTextField.hintColor = UIColorFromRGB(216.0f, 216.0f, 216.0f);
  self.pwdTextField.hint = @"请输入密码";
  self.pwdTextField.secureTextEntry = YES;
  self.pwdTextField.textColor = [UIColor blackColor];
  [self.secondView addSubview:self.pwdTextField];
  
  UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, pwdLine.bottom + 32.0f, 290.0f, 37.0f)];
  loginButton.centerX = self.view.centerX;
  [loginButton setBackgroundImage:[UIImage imageNamed:@"login_normal.png"] forState:UIControlStateNormal];
  loginButton.tintColor = [UIColor whiteColor];
  loginButton.titleLabel.font = UIFontOfSize(16.0f);
  [loginButton setTitle:@"登录" forState:UIControlStateNormal];
  [loginButton addTarget:self action:@selector(onLoginClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.secondView addSubview:loginButton];
  UILabel *forgetLabel = [UILabel createLabelWithFrame:CGRectMake(0, loginButton.bottom + 18.0f, 103.0f, 22.0f)
                                              withSize:12.0f withColor:UIColorFromRGB(8.0f, 103.0f, 177.0f)];
  forgetLabel.centerX = self.view.centerX;
  forgetLabel.text = @"忘记密码或用户名?";
  [forgetLabel addTapCallBack:self sel:@selector(onForgetClick:)];
  [self.secondView addSubview:forgetLabel];
  
  LKDBHelper *lkdbHelper = [DBHelper getUsingLKDBHelper];
  [lkdbHelper search:[AccountData class] where:@"" orderBy:@"loginTime DESC" offset:0 count:10 callback:^(NSMutableArray *array) {
    if (array.count>0) {
      self.accArray = array;
      AccountData *ad = (AccountData*)array[0];
      dispatch_sync(dispatch_get_main_queue(), ^{
        self.nameTextField.text = ad.avatar;
        self.pwdTextField.text = ad.pwd;
      });
    }
  }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  
  return YES;
}

-(void)onAccClick
{
  if (self.accArray.count>1) {
    if (self.accTableView.hidden) {
      self.accTableView.hidden = NO;
      self.secondView.frame = CGRectMake(0, self.accTableView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.accTableView.bottom);
    }else{
      self.secondView.frame = CGRectMake(0, self.nameTextField.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.nameTextField.bottom);
      self.accTableView.hidden = YES;
    }
  }
}

- (void)onLoginClick:(id)sender
{
  NSString *name = self.nameTextField.textValue;
  if (ISEMPTY(name)) {
    [self showToast:@"请输入用户名"];
    return;
  }
  NSString *pwd = self.pwdTextField.textValue;
  if (ISEMPTY(pwd)) {
    [self showToast:@"请输入密码"];
    return;
  }
  [self showHUD];
  [self.loginModel loginWithName:name pwd:pwd];
}

- (void)onForgetClick:(id)sender
{
  ForgetPwdViewController *controller = [[ForgetPwdViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer
{
  if (self.nameTextField.isFirstResponder) {
    [self.nameTextField resignFirstResponder];
  }
  if (self.pwdTextField.isFirstResponder) {
    [self.pwdTextField resignFirstResponder];
  }
}

#pragma mark --tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.accArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellTableIdentifier = @"accListCell";
  
  HTBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
  if (cell == nil) {
    cell = [[HTBaseCell alloc] initWithReuseIdentifier:CellTableIdentifier];
  }
  cell.highlightedView.backgroundColor = UIColorFromRGB(233.0f, 233.0f, 233.0f);
  AccountData *ad = [self.accArray objectAtIndex:indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@    %@",ad.nick,ad.avatar];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 30.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"didSelectRowAtIndexPath");
  self.secondView.frame = CGRectMake(0, self.nameTextField.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.nameTextField.bottom);
  self.accTableView.hidden = YES;
  AccountData *ad = [self.accArray objectAtIndex:indexPath.row];
  self.nameTextField.text = ad.avatar;
  self.pwdTextField.text = ad.pwd;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
    return NO;
  }
  return YES;
}

#pragma mark - LoginModelProtocol
- (void)loginFinished:(UserResponse *)response
{
    HTAppContext *appContext = [HTAppContext sharedContext];
    appContext.uid = response.data.uid;
    [appContext save];
    
    HTUserData *userData = [HTUserData sharedInstance];
    userData.token = response.token;
    userData.isFresh = response.data.isfresh;
    userData.age = response.data.age;
    userData.avatar = response.data.avatar;
    userData.birthday = response.data.birthday;
    userData.coachTel = response.data.coachTel;
//userData.device = response.device;
    userData.height = response.data.height;
    userData.isCoach = response.data.isCoach;
    userData.nick = response.data.nick;
    userData.sex = response.data.sex;
    userData.tel = response.data.tel;
    userData.uid = response.data.uid;
    [userData save];
    
    NSString *name = self.nameTextField.textValue;
    NSString *pwd = self.pwdTextField.textValue;
    
    AccountData *accountData = [[AccountData alloc]init];
    accountData.avatar = response.data.avatar;
    accountData.pwd = pwd;
    accountData.nick = response.data.nick;
    accountData.loginTime = [[NSDate date] timeIntervalSince1970];
    LKDBHelper *lkdbHelper = [DBHelper getUsingLKDBHelper];
    [lkdbHelper deleteWithClass:[AccountData class] where:[NSString stringWithFormat:@"avatar=%@",name] callback:^(BOOL result) {
        [lkdbHelper insertToDB:accountData];
    }];

    [APP_DELEGATE showHomeView];
}

@end
