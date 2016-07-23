//
//  ForgetPwdViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "ForgetPwdViewController.h"

#import "HTSendCodeModel.h"
#import "SendCodeModelHandler.h"
#import "HTCheckCodeModel.h"
#import "CheckCodeModelHandler.h"

#import "SetPwdViewController.h"

@interface ForgetPwdViewController ()<SendCodeModelProtocol, CheckCodeModelProtocol>

@property (nonatomic, strong) HTTextField *phoneTextField;
@property (nonatomic, strong) HTTextField *codeTextField;
@property (nonatomic, strong) UILabel *codeLabel;

@property (nonatomic, strong) HTSendCodeModel *sendCodeModel;
@property (nonatomic, strong) SendCodeModelHandler *sendCodeModelHandler;
@property (nonatomic, strong) HTCheckCodeModel *checkCodeModel;
@property (nonatomic, strong) CheckCodeModelHandler *checkCodeModelHandler;

@end

@implementation ForgetPwdViewController

- (void)initNavbar
{
  self.title = @"忘记密码";
}

- (void)initModel
{
  self.sendCodeModelHandler = [[SendCodeModelHandler alloc] initWithController:self];
  self.sendCodeModel = [[HTSendCodeModel alloc] initWithHandler:self.sendCodeModelHandler];
  self.checkCodeModelHandler = [[CheckCodeModelHandler alloc] initWithController:self];
  self.checkCodeModel = [[HTCheckCodeModel alloc] initWithHandler:self.checkCodeModelHandler];
}

- (void)initView
{
  [self.view addTapCallBack:self sel:@selector(didTapAnywhere:)];
  UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(26.0f, 47.0f, self.view.width - 52.0f, 38.0f)];
  phoneView.layer.cornerRadius = 4.0f;
  phoneView.layer.masksToBounds = YES;
  phoneView.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  phoneView.layer.borderWidth = 0.5f;
  phoneView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:phoneView];
  self.phoneTextField = [[HTTextField alloc] initWithFrame:CGRectMake(phoneView.left + 10.0f, phoneView.top, phoneView.width - 10.0f, phoneView.height)];
  self.phoneTextField.hint = @"请输入手机号";
  self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
  self.phoneTextField.textColor = [UIColor blackColor];
  [self.view addSubview:self.phoneTextField];
  UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(26.0f, phoneView.bottom + 9.0f, 141.0f, 38.0f)];
  codeView.layer.cornerRadius = 4.0f;
  codeView.layer.masksToBounds = YES;
  codeView.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  codeView.layer.borderWidth = 0.5f;
  codeView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:codeView];
  self.codeTextField = [[HTTextField alloc] initWithFrame:CGRectMake(codeView.left + 10.0f, codeView.top, codeView.width - 10.0f, codeView.height)];
  self.codeTextField.hint = @"请输入验证码";
  self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
  self.codeTextField.textColor = [UIColor blackColor];
  [self.view addSubview:self.codeTextField];
  self.codeLabel = [UILabel createLabelWithFrame:CGRectMake(codeView.right + 12.0f, codeView.top, phoneView.width - codeView.width - 12.0f,
                                                            codeView.height) withSize:15.0f withColor:[UIColor whiteColor]];
  self.codeLabel.layer.cornerRadius = 4.0f;
  self.codeLabel.layer.masksToBounds = YES;
  self.codeLabel.backgroundColor = UIColorFromRGB(108.0f, 205.0f, 239.0f);
  self.codeLabel.textAlignment = NSTextAlignmentCenter;
  self.codeLabel.text = @"获取验证码";
  [self.codeLabel addTapCallBack:self sel:@selector(onPhoneCodeClick:)];
  [self.view addSubview:self.codeLabel];
  UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, codeView.bottom + 32.0f, 290.0f, 37.0f)];
  submitButton.centerX = self.view.centerX;
  [submitButton setBackgroundImage:[UIImage imageNamed:@"login_normal.png"] forState:UIControlStateNormal];
  submitButton.tintColor = [UIColor whiteColor];
  submitButton.titleLabel.font = UIFontOfSize(16.0f);
  [submitButton setTitle:@"提交" forState:UIControlStateNormal];
  [submitButton addTarget:self action:@selector(onSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:submitButton];
}

- (void)onSubmitClick:(id)sender
{
  NSString *phone = self.phoneTextField.textValue;
  if (ISEMPTY(phone)) {
    [self showToast:@"请输入手机号"];
    return;
  }
  NSString *code = self.codeTextField.textValue;
  if (ISEMPTY(code)) {
    [self showToast:@"请输入验证码"];
    return;
  }
  [self showHUDWithLabel:@"正在验证输入信息"];
  [self.checkCodeModel checkCode:code phone:phone];
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer
{
  if (self.phoneTextField.isFirstResponder) {
    [self.phoneTextField resignFirstResponder];
  }
  if (self.codeTextField.isFirstResponder) {
    [self.codeTextField resignFirstResponder];
  }
}

- (void)refreshPhoneCodeButton
{
  int second = self.codeLabel.tag;
  if (second == 1) {
    self.codeLabel.text = @"获取验证码";
  } else {
    second--;
    self.codeLabel.text = [NSString stringWithFormat:@"重新发送 (%d秒)", second];
    self.codeLabel.tag = second;
    [self performSelector:@selector(refreshPhoneCodeButton) withObject:nil afterDelay:1];
  }
}

- (void)onPhoneCodeClick:(id)sender
{
  if (![self.codeLabel.text isEqualToString:@"获取验证码"]) {
    return;
  }
  NSString *phoneStr = self.phoneTextField.textValue;
  if (ISEMPTY(phoneStr)) {
    [self showToast:@"请输入您的手机号"];
    return;
  }
//  if (![phoneStr isMobile]) {
//    [self showToast:@"输入的手机号不合法"];
//    return;
//  }
  [self.sendCodeModel sendCode:phoneStr type:@"findpwd"];
  self.codeLabel.text = @"重新发送 (60)";
  self.codeLabel.tag = 60;
  [self performSelector:@selector(refreshPhoneCodeButton) withObject:nil afterDelay:1];
}

#pragma mark - SendCodeModelProtocol
- (void)sendCodeFinished:(BaseResponse *)response
{
  [self showToast:@"验证码发送成功，请注意查收"];
}

#pragma mark - CheckCodeModelProtocol
- (void)checkCodeFinished:(BaseResponse *)response
{
  SetPwdViewController *controller = [[SetPwdViewController alloc] init];
  controller.phone = self.phoneTextField.textValue;
  controller.qcode = self.codeTextField.textValue;
  [self.navigationController pushViewController:controller animated:YES];
}

@end
