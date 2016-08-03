//
//  RegisterViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/2.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "RegisterViewController.h"

#import "AppDelegate.h"
#import "CommonHelper.h"
#import "PicturePicker.h"
#import "HeightPicker.h"
#import "BirthdayPicker.h"

#import "UpLoadAvatarModel.h"
#import "UploadAvatarModelHandler.h"
#import "HTRegisterModel.h"
#import "RegisterModelHandler.h"
#import "HTCheckTelAndNickModel.h"
#import "CheckCodeModelHandler.h"
#import "AccountData.h"
#import "DBHelper.h"
#import "RegAgreementViewController.h"

#import "BuildvtelResponse.h"
#import "BuildvtelModel.h"
#import "BuildvtelModelHandler.h"

#define K_TextFontF             [UIFont systemFontOfSize:13]

#define K_TextColorB                        [UIColor colorWithRed:40 green:120 blue:160 alpha:1]

#define K_TextColorC                        [UIColor colorWithRed:153 green:153 blue:153 alpha:1]

static int const kPageSize = 5;

@interface RegisterViewController ()<UIScrollViewDelegate, PicturePickerProtocol, UploadAvatarModelProtocol, HeightPickerProtocol, BirthdayPickerProtocol, RegisterModelProtocol, CheckCodeModelProtocol,BuildvtelModelProtocol>

@property (nonatomic, strong) NSMutableArray *dotArray;
@property (nonatomic, assign) int dotIndex;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *avatarLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIView *slideView;
@property (nonatomic, strong) HTTextField *nameTextField;
@property (nonatomic, strong) HTTextField *phoneTextField;
@property (nonatomic, strong) HTTextField *pwdTextField;
@property (nonatomic, strong) HTTextField *rePwdTextField;
@property (nonatomic, strong) UILabel *heightLabel;
@property (nonatomic, strong) UILabel *manLabel;
@property (nonatomic, strong) UILabel *womanLabel;
@property (nonatomic, strong) UILabel *birthdayLabel;
@property (nonatomic, strong) HTTextField *tPhoneTextField;
@property (nonatomic, strong) HTTextField *noTextField;

@property (nonatomic, strong) PicturePicker *picturePicker;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) NSString *heightStr;
@property (nonatomic, strong) HeightPicker *heightPicker;
@property (nonatomic, assign) int sex;
@property (nonatomic, strong) BirthdayPicker *birthdayPicker;
@property (nonatomic, strong) NSString *birthdayStr;

@property (nonatomic, strong) UpLoadAvatarModel *upLoadAvatarModel;
@property (nonatomic, strong) UploadAvatarModelHandler *uploadAvatarModelHandler;
@property (nonatomic, strong) HTRegisterModel *registerModel;
@property (nonatomic, strong) RegisterModelHandler *registerModelHandler;
@property (nonatomic, strong) HTCheckTelAndNickModel *checkModel;
@property (nonatomic, strong) CheckCodeModelHandler *checkModelHandler;

@property (nonatomic, strong) BuildvtelModel *buildModel;
@property (nonatomic, strong) BuildvtelModelHandler *buildModelHandler;

@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation RegisterViewController

- (void)initNavbar
{
    self.title = @"用户名";
  self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
  [self.nextButton setImage:[UIImage imageNamed:@"next_nav_bar.png"] forState:UIControlStateNormal];
  [self.nextButton addTarget:self action:@selector(onNextClick:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.nextButton];
  self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addNotification
{
  [self handleKeyboard];
}

- (void)removeNotification
{
  [self removeKeyboard];
}

- (void)initModel
{
  self.uploadAvatarModelHandler = [[UploadAvatarModelHandler alloc] initWithController:self];
  self.upLoadAvatarModel = [[UpLoadAvatarModel alloc] initWithHandler:self.uploadAvatarModelHandler];
  self.registerModelHandler = [[RegisterModelHandler alloc] initWithController:self];
  self.registerModel = [[HTRegisterModel alloc] initWithHandler:self.registerModelHandler];
  self.checkModelHandler = [[CheckCodeModelHandler alloc] initWithController:self];
  self.checkModel = [[HTCheckTelAndNickModel alloc] initWithHandler:self.checkModelHandler];
    
    self.buildModelHandler = [[BuildvtelModelHandler alloc] initWithController:self];
    self.buildModel = [[BuildvtelModel alloc] initWithHandler:self.buildModelHandler];
    
//    [self.buildModel randomtel];
}

- (void)initView
{
  [self.view addTapCallBack:self sel:@selector(didTapAnywhere:)];
  self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
  self.dotIndex = 0;
  self.sex = -1;
  self.avatarUrl = @"";
  self.dotArray = [NSMutableArray arrayWithCapacity:kPageSize];
  CGFloat left = (self.view.width - 16.0f * kPageSize - 53.0f * (kPageSize - 1)) / 2.0f;
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left + 2.0f, 22.0f, self.view.width - 2 * (left + 2.0f), 2.0f)];
  lineView.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
  [self.view addSubview:lineView];
  for (int i = 0; i < kPageSize; i++) {
    UIImageView *dotView = [[UIImageView alloc] initWithFrame:CGRectMake(left, 15.0f, 16.0f, 16.0f)];
    if (i == 0) {
      dotView.image = [UIImage imageNamed:@"register_dot_selected.png"];
    } else {
      dotView.image = [UIImage imageNamed:@"register_dot_normal.png"];
    }
    [self.view addSubview:dotView];
    [self.dotArray addObject:dotView];
    left = dotView.right + 53.0f;
  }
  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 31.0f, self.view.width, self.view.height - 31.0f - 100)];
  self.scrollView.showsHorizontalScrollIndicator = NO;
  self.scrollView.showsVerticalScrollIndicator = NO;
  self.scrollView.pagingEnabled = YES;
  self.scrollView.scrollsToTop = NO;
  self.scrollView.scrollEnabled = NO;
  self.scrollView.delegate = self;
  self.scrollView.contentSize = CGSizeMake(self.scrollView.width * kPageSize, self.scrollView.height);
  [self.view addSubview:self.scrollView];
  //firstView
  UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height)];
  [self.scrollView addSubview:firstView];
  self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 24.0f, 79.0f, 79.0f)];
  self.avatarImageView.centerX = firstView.centerX;
  self.avatarImageView.layer.masksToBounds = YES;
  self.avatarImageView.layer.cornerRadius = 39.5f;
  self.avatarImageView.image = [UIImage imageNamed:@"register_avatar.png"];
  [self.avatarImageView addTapCallBack:self sel:@selector(updateAvatarClick:)];
  [firstView addSubview:self.avatarImageView];
  self.avatarLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.avatarImageView.bottom + 7.0f, 26.0f, 26.0f)
                                              withSize:13.0f withColor:UIColorFromRGB(116.0f, 116.0f, 116.0f)];
  self.avatarLabel.centerX = firstView.centerX;
  [self.avatarLabel addTapCallBack:self sel:@selector(updateAvatarClick:)];
  self.avatarLabel.text = @"头像";
  [firstView addSubview:self.avatarLabel];
  self.slideView = [[UIView alloc] initWithFrame:CGRectMake(0, self.avatarLabel.bottom + 15.0f, firstView.width, 179.0f)];
  self.slideView.backgroundColor = self.view.backgroundColor;
  [firstView addSubview:self.slideView];
  self.nameTextField = [self createTextField:0 hint:@"请输入用户名" isPwd:NO supview:self.slideView];
  self.phoneTextField = [self createTextField:self.nameTextField.bottom + 9.0f hint:@"请输入手机号" isPwd:NO supview:self.slideView];
  self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
  self.pwdTextField = [self createTextField:self.phoneTextField.bottom + 9.0f hint:@"请输入密码" isPwd:YES supview:self.slideView];
  self.pwdTextField.text = @"111111";
  self.rePwdTextField = [self createTextField:self.pwdTextField.bottom + 9.0f hint:@"请再次输入密码" isPwd:YES supview:self.slideView];
  self.rePwdTextField.text = @"111111";
//    self.phoneTextField.enabled = NO;
  //secondView
  UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height)];
  [self.scrollView addSubview:secondView];
  UILabel *heightLabel = [UILabel createLabelWithFrame:CGRectMake(0, 21.0f, 73.0f, 16.0f)
                                              withSize:13.0f withColor:UIColorFromRGB(58.0f, 58.0f, 58.0f)];
  heightLabel.centerX = secondView.width / 2.0f;
  heightLabel.text = @"请问你多高?";
  [secondView addSubview:heightLabel];
  self.heightLabel = [UILabel createLabelWithFrame:CGRectMake(0, heightLabel.bottom + 15.0f, 109.0f, 38.0f)
                                          withSize:13.0f withColor:UIColorFromRGB(116.0f, 116.0f, 116.0f)];
  self.heightLabel.centerX = secondView.width / 2.0f;
  self.heightLabel.textAlignment = NSTextAlignmentCenter;
  self.heightLabel.backgroundColor = [UIColor whiteColor];
  self.heightLabel.layer.cornerRadius = 4.0f;
  self.heightLabel.layer.masksToBounds = YES;
  self.heightLabel.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  self.heightLabel.layer.borderWidth = 0.5f;
  [self.heightLabel addTapCallBack:self sel:@selector(onHeightClick:)];
  [secondView addSubview:self.heightLabel];
  UILabel *heightNoticeLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.heightLabel.bottom + 54.0f, 143.0f, 14.0f)
                                                    withSize:11.0f withColor:UIColorFromRGB(157.0f, 157.0f, 157.0f)];
  heightNoticeLabel.centerX = secondView.width / 2.0f;
  heightNoticeLabel.text = @"可以进行估计，稍后可以修改";
  [secondView addSubview:heightNoticeLabel];
  //thirdView
  UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width * 2, 0, self.scrollView.width, self.scrollView.height)];
  [self.scrollView addSubview:thirdView];
  UILabel *sexLabel = [UILabel createLabelWithFrame:CGRectMake(0, 21.0f, 73.0f, 16.0f)
                                              withSize:13.0f withColor:UIColorFromRGB(58.0f, 58.0f, 58.0f)];
  sexLabel.textAlignment = NSTextAlignmentCenter;
  sexLabel.centerX = thirdView.width / 2.0f;
  sexLabel.text = @"我是";
  [thirdView addSubview:sexLabel];
  self.manLabel = [UILabel createLabelWithFrame:CGRectMake((thirdView.width - 218.0f) / 2.0f, sexLabel.bottom + 14.0f, 109.0f, 34.0f)
                                       withSize:14.0f withColor:UIColorFromRGB(130.0f, 130.0f, 130.0f)];
  self.manLabel.textAlignment = NSTextAlignmentCenter;
  self.manLabel.highlightedTextColor = [UIColor whiteColor];
  self.manLabel.layer.borderWidth = 0.5f;
  self.manLabel.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  self.manLabel.backgroundColor = [UIColor whiteColor];
  self.manLabel.text = @"男";
  self.manLabel.tag = 1;
  [self.manLabel addTapCallBack:self sel:@selector(onSexClick:)];
  [thirdView addSubview:self.manLabel];
  self.womanLabel = [UILabel createLabelWithFrame:CGRectMake(self.manLabel.right, self.manLabel.top, 109.0f, 34.0f)
                                       withSize:14.0f withColor:UIColorFromRGB(130.0f, 130.0f, 130.0f)];
  self.womanLabel.textAlignment = NSTextAlignmentCenter;
  self.womanLabel.highlightedTextColor = [UIColor whiteColor];
  self.womanLabel.layer.borderWidth = 0.5f;
  self.womanLabel.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  self.womanLabel.backgroundColor = [UIColor whiteColor];
  self.womanLabel.text = @"女";
  self.womanLabel.tag = 2;
  [self.womanLabel addTapCallBack:self sel:@selector(onSexClick:)];
  [thirdView addSubview:self.womanLabel];
  UILabel *birthdayTitleLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.womanLabel.bottom, thirdView.width, 42.0f)
                                                     withSize:13.0f withColor:UIColorFromRGB(58.0f, 58.0f, 58.0f)];
  birthdayTitleLabel.textAlignment = NSTextAlignmentCenter;
  birthdayTitleLabel.text = @"请输入你的生日";
  [thirdView addSubview:birthdayTitleLabel];
  self.birthdayLabel = [UILabel createLabelWithFrame:CGRectMake(0, birthdayTitleLabel.bottom, 109.0f, 34.0f)
                                            withSize:13.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  self.birthdayLabel.centerX = thirdView.width / 2.0f;
  self.birthdayLabel.textAlignment = NSTextAlignmentCenter;
  self.birthdayLabel.backgroundColor = [UIColor whiteColor];
  self.birthdayLabel.layer.borderWidth = 0.5f;
  self.birthdayLabel.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  [self.birthdayLabel addTapCallBack:self sel:@selector(onBirthdayClick:)];
  [thirdView addSubview:self.birthdayLabel];
  //fourthView
  UIView *fourthView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width * 3, 0, self.scrollView.width, self.scrollView.height)];
  [self.scrollView addSubview:fourthView];
  self.tPhoneTextField = [self createTextField:22.0f hint:@"请输入手机号" isPwd:NO supview:fourthView];
  self.tPhoneTextField.text = @"11111111111";
  self.tPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
  UILabel *tPhoneNoticeLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.tPhoneTextField.bottom + 54.0f, fourthView.width, 14.0f)
                                                    withSize:11.0f withColor:UIColorFromRGB(157.0f, 157.0f, 157.0f)];
  tPhoneNoticeLabel.textAlignment = NSTextAlignmentCenter;
  tPhoneNoticeLabel.text = @"填写V教练的手机号";
  [fourthView addSubview:tPhoneNoticeLabel];
  //fifthView
  UIView *fifthView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width * 4, 0, self.scrollView.width, self.scrollView.height)];
  [self.scrollView addSubview:fifthView];
  UILabel *preLabel = [UILabel createLabelWithFrame:CGRectMake(25.0f, 0, 126.0f, 57.0f)
                                           withSize:14.0f withColor:UIColorFromRGB(63.0f, 63.0f, 63.0f)];
  preLabel.text = @"如无设备号，请点此";
  [fifthView addSubview:preLabel];
  UILabel *passLabel = [UILabel createLabelWithFrame:CGRectMake(preLabel.right, 0, 28.0f, 57.0f)
                                            withSize:14.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  passLabel.text = @"跳过";
  [passLabel addTapCallBack:self sel:@selector(onPassClick:)];
  [fifthView addSubview:passLabel];
  UIView *passLine = [[UIView alloc] initWithFrame:CGRectMake(passLabel.left, 37.0f, passLabel.width, 0.5f)];
  passLine.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
  [fifthView addSubview:passLine];
  self.noTextField = [self createTextField:passLabel.bottom hint:@"请输入设备号" isPwd:NO supview:fifthView];
  HTAppContext *appContext = [HTAppContext sharedContext];
  self.noTextField.text = appContext.device;
  UILabel *noNoticeLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.noTextField.bottom + 31.0f, fifthView.width, 14.0f)
                                                    withSize:11.0f withColor:UIColorFromRGB(157.0f, 157.0f, 157.0f)];
  noNoticeLabel.text = @"“设备号”请查看称背面面贴的标签上";
  noNoticeLabel.textAlignment = NSTextAlignmentCenter;
  [fifthView addSubview:noNoticeLabel];
    
    
    NSString *befor = @"注册即代表同意";
    NSString *next1 = @"好易达隐私策略";
    NSString *next2 = @"用户使用协议";
    NSString *str = [NSString stringWithFormat:@"%@%@和%@",befor,next1,next2];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text setAttributes:@{NSFontAttributeName:K_TextFontF,NSForegroundColorAttributeName:UIColorFromRGB(116.0f, 116.0f, 116.0f)} range:[str rangeOfString:befor]];
    [text setAttributes:@{NSFontAttributeName:K_TextFontF,NSForegroundColorAttributeName:UIColorFromRGB(56, 150, 213)} range:[str rangeOfString:next1]];
    [text setAttributes:@{NSFontAttributeName:K_TextFontF,NSForegroundColorAttributeName:UIColorFromRGB(116.0f, 116.0f, 116.0f)} range:[str rangeOfString:@"和"]];
    [text setAttributes:@{NSFontAttributeName:K_TextFontF,NSForegroundColorAttributeName:UIColorFromRGB(56, 150, 213)} range:[str rangeOfString:next2]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - 44 - 10 - 64, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.text = str;
    label.font = K_TextFontF;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    label.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - size.width)/2, CGRectGetHeight([UIScreen mainScreen].bounds) - 44 - 10 - 64, size.width, 20);
    label.text = nil;
    label.attributedText = text;
    label.userInteractionEnabled = YES;
    [self.view addSubview:label];

    UIButton *protocol = [UIButton buttonWithType:UIButtonTypeCustom];
    protocol.frame = CGRectMake(size.width - 78, 0, 78, 20);
    [protocol addTarget:self action:@selector(protocolAction) forControlEvents:UIControlEventTouchUpInside];
    [label addSubview:protocol];
    
    UIButton *privacy = [UIButton buttonWithType:UIButtonTypeCustom];
    privacy.frame = CGRectMake(size.width - 78 - 12 - 84, 0, 83, 20);
    [privacy addTarget:self action:@selector(privacyAction) forControlEvents:UIControlEventTouchUpInside];
    [label addSubview:privacy];
}

-(void)updateAvatarClick:(id)sender
{
  [self didTapAnywhere:nil];
  if (nil == self.picturePicker) {
    self.picturePicker = [[PicturePicker alloc] initWithController:self];
    self.picturePicker.type = PicturePickerAvatar;
  }
  [self.picturePicker showActionSheet:nil];
}

- (void)onSexClick:(UITapGestureRecognizer *)sender
{
  NSInteger tag = sender.view.tag;
  if (1 == tag) {
    self.sex = 1;
    self.manLabel.backgroundColor = UIColorFromRGB(248.0f, 139.0f, 58.0f);
    self.womanLabel.backgroundColor = [UIColor whiteColor];
    self.manLabel.highlighted = YES;
    self.womanLabel.highlighted = NO;
  } else {
    self.sex = 0;
    self.manLabel.backgroundColor = [UIColor whiteColor];
    self.womanLabel.backgroundColor = UIColorFromRGB(248.0f, 139.0f, 58.0f);
    self.manLabel.highlighted = NO;
    self.womanLabel.highlighted = YES;
  }
}

- (void)onBirthdayClick:(id)sender
{
  if (nil == self.birthdayPicker) {
    self.birthdayPicker = [[BirthdayPicker alloc] initWithController:self];
  }
  [self.birthdayPicker showBirthdayPicker];
}

- (HTTextField *)createTextField:(CGFloat)top hint:(NSString *)hint isPwd:(BOOL)isPwd supview:(UIView *)supview
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(25.0f, top, supview.width - 50.0f, 38.0f)];
  view.backgroundColor = [UIColor whiteColor];
  view.layer.cornerRadius = 4.0f;
  view.layer.masksToBounds = YES;
  view.layer.borderColor = UIColorFromRGB(229.0f, 229.0f, 229.0f).CGColor;
  view.layer.borderWidth = 0.5f;
  [supview addSubview:view];
  HTTextField *textField = [[HTTextField alloc] initWithFrame:CGRectMake(view.left + 10.0f, view.top, view.width - 10.0f, 38.0f)];
  textField.hint = hint;
  textField.hintColor = UIColorFromRGB(226.0f, 226.0f, 226.0f);
  textField.textColor = [UIColor blackColor];
  textField.secureTextEntry = isPwd;
  textField.font = UIFontOfSize(13.0f);
  [supview addSubview:textField];
//    
//    if ([hint isEqualToString:@"请输入手机号"]&&supview == self.slideView)
//    {
//        textField.frame = CGRectMake(view.left + 10.0f, view.top, view.width - 10.0f - 80, 38.0f);
//        UIButton *reg = [UIButton buttonWithType:UIButtonTypeCustom];
//        reg.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
//        reg.frame = CGRectMake(textField.right + 5,view.top + 5,70,textField.height-10);
//        reg.layer.cornerRadius = 2;
//        reg.layer.masksToBounds = YES;
//        reg.titleLabel.font = UIFontOfSize(13.0f);
//        [reg setTitle:@"随机" forState:UIControlStateNormal];
//        [reg addTarget:self action:@selector(randomAction) forControlEvents:UIControlEventTouchUpInside];
//        [supview addSubview:reg];
//    }
    
  return textField;
}

- (void)onNextClick:(id)sender
{
  if (0 == self.dotIndex) {
    NSString *name = [self.nameTextField textValue];
    if (ISEMPTY(name)) {
      [self showToast:@"请输入用户名"];
      return;
    }
    NSString *phone = [self.phoneTextField textValue];
    if (ISEMPTY(phone)) {
      [self showToast:@"请输入手机号"];
      return;
    }
    if (phone.length < 7) {
      [self showToast:@"您输入的手机号位数不对"];
      return;
    }
    NSString *pwd = [self.pwdTextField textValue];
    if (ISEMPTY(pwd)) {
      [self showToast:@"请输入密码"];
      return;
    }
    NSString *rePwd = [self.rePwdTextField textValue];
    if (ISEMPTY(rePwd)) {
      [self showToast:@"请再次输入密码"];
      return;
    }
    if (![pwd isEqualToString:rePwd]) {
      [self showToast:@"两次输入的密码不一致，请重新确认"];
      return;
    }
    [self showHUDWithLabel:@"校验录入信息"];
    [self.checkModel checkTel:phone nickName:name];
    return;
  } else if (1 == self.dotIndex) {
    NSString *heightStr = self.heightLabel.text;
    if (ISEMPTY(heightStr)) {
      [self showToast:@"请选择您的身高"];
      return;
    }
  } else if (2 == self.dotIndex) {
    if (self.sex < 0) {
      [self showToast:@"请选择性别"];
      return;
    }
    NSString *birthdayStr = self.birthdayLabel.text;
    if (ISEMPTY(birthdayStr)) {
      [self showToast:@"请选择您的生日"];
      return;
    }
  } else if (3 == self.dotIndex) {
    NSString *phone = self.tPhoneTextField.textValue;
    if (ISEMPTY(phone)) {
      [self showToast:@"请输入V教练的手机号"];
      return;
    }
    if (phone.length < 7) {
      [self showToast:@"您输入的手机号位数不对"];
      return;
    }
  } else if (4 == self.dotIndex) {
      NSString *device = self.noTextField.textValue;
      if (/*ISEMPTY(device)*/device.length<6) {
          [self showToast:@"请输入6位或6位以上设备号"];
          return;
      }
  }
  [self didTapAnywhere:nil];
  self.dotIndex++;
  if (self.dotIndex >= kPageSize) {
      NSString *oldDevi = self.noTextField.textValue;
      NSString *subDev = [oldDevi substringWithRange:NSMakeRange(oldDevi.length-6, 6)];
      NSString *device = [NSString stringWithFormat:@"HYD-%@",subDev];
    [self onRegister:device];
    return;
  }
  [self.scrollView setContentOffset:CGPointMake(self.dotIndex * self.scrollView.width, 0) animated:YES];
}

- (void)onPassClick:(id)sender
{
  [self onRegister:@""];
}

- (void)onRegister:(NSString *)device
{
  HTAppContext *appContext = [HTAppContext sharedContext];
  appContext.device = device;
  [appContext saveDevice];
  [self showHUDWithLabel:@"正在上传注册信息"];
  [self.registerModel registerWithNick:self.nameTextField.textValue pwd:self.pwdTextField.textValue height:self.heightStr
                                   sex:self.sex birthday:self.birthdayStr tel:self.phoneTextField.textValue coachTel:self.tPhoneTextField.textValue
                                avatar:self.avatarUrl device:device];
}

- (void)onBackViewController:(id)sender
{
  self.dotIndex--;
  if (self.dotIndex >= 0) {
    [self.scrollView setContentOffset:CGPointMake(self.dotIndex * self.scrollView.width, 0) animated:YES];
  } else {
    [super onBackViewController:sender];
  }
}

- (void)onHeightClick:(id)sender
{
  if (nil == self.heightPicker) {
    self.heightPicker = [[HeightPicker alloc] initWithController:self];
  }
  [self.heightPicker showHeightPicker];
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer
{
  if (self.nameTextField.isFirstResponder) {
    [self.nameTextField resignFirstResponder];
  }
  if (self.phoneTextField.isFirstResponder) {
    [self.phoneTextField resignFirstResponder];
  }
  if (self.pwdTextField.isFirstResponder) {
    [self.pwdTextField resignFirstResponder];
  }
  if (self.rePwdTextField.isFirstResponder) {
    [self.rePwdTextField resignFirstResponder];
  }
  if (self.tPhoneTextField.isFirstResponder) {
    [self.tPhoneTextField resignFirstResponder];
  }
  if (self.noTextField.isFirstResponder) {
    [self.noTextField resignFirstResponder];
  }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat pageWidth = scrollView.width;
  int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
  if (self.dotIndex != page) {
    int len = self.dotArray.count;
    for (int i = 0; i < len; i++) {
      UIImageView *imageView = [self.dotArray objectAtIndex:i];
      if (i <= page) {
        imageView.image = [UIImage imageNamed:@"register_dot_selected.png"];
      } else {
        imageView.image = [UIImage imageNamed:@"register_dot_normal.png"];
      }
    }
    self.dotIndex = page;
    if (0 == self.dotIndex) {
      self.title = @"用户名";
    } else if (1 == self.dotIndex || 2 == self.dotIndex) {
      self.title = @"你";
    } else if (3 == self.dotIndex) {
      self.title = @"V教练";
      [self.nextButton setImage:[UIImage imageNamed:@"next_nav_bar.png"] forState:UIControlStateNormal];
    } else if (4 == self.dotIndex) {
      self.title = @"设备号";
      [self.nextButton setImage:[UIImage imageNamed:@"check_mark_nav_bar.png"] forState:UIControlStateNormal];
    }
  }
}

#pragma mark - PicturePickerProtocol
- (void)selectImage:(UIImage *)image
{
  self.avatar = image;
  [self showHUDWithLabel:@"正在上传头像..."];
  [self.upLoadAvatarModel uploadAvatarWithImage:image];
}

#pragma mark - UploadAvatarModelProtocol
- (void)uploadAvatarFinished:(UploadAvatarResponse *)response
{
  [self hideHUD];
  self.avatarImageView.image = self.avatar;
  self.avatarUrl = response.avatar;
}

#pragma mark - Keyboard Notification Functions
- (void)keyboardWillShow:(NSNotification *)notification
{
  if (0 == self.dotIndex) {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.slideView.top = 0;
    [UIView commitAnimations];
  }
//  [self.view addGestureRecognizer:_tapRecognizer];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  if (0 == self.dotIndex) {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.slideView.top = self.avatarLabel.bottom + 15.0f;
    [UIView commitAnimations];
  }
//  [self.view removeGestureRecognizer:_tapRecognizer];
}

#pragma mark - HeightPickerProtocol
- (void)selectHeight:(NSString *)height
{
  self.heightStr = height;
  self.heightLabel.text = [NSString stringWithFormat:@"%@厘米", height];
}

#pragma mark - BirthdayPickerProtocol
- (void)selectedBirthday:(NSString *)birthday time:(NSString *)time
{
  self.birthdayLabel.text = birthday;
  self.birthdayStr = time;
}

#pragma mark - RegisterModelProtocol
- (void)registerFinished:(UserResponse *)response
{
//    HTAppContext *appContext = [HTAppContext sharedContext];
//    appContext.uid = response.uid;
//    [appContext save];
//    HTUserData *userData = [HTUserData sharedInstance];
//    userData.age = response.age;
//    userData.avatar = response.avatar;
//    userData.birthday = response.birthday;
//    userData.coachTel = response.coachTel;
//    //  userData.device = response.device;
//    userData.height = response.height;
//    userData.isCoach = response.isCoach;
//    userData.nick = response.nick;
//    userData.sex = response.sex;
//    userData.tel = response.tel;
//    userData.uid = response.uid;
//    userData.isFresh = response.isFresh;
//    [userData save];
//    
//    NSString *name = self.nameTextField.textValue;
//    NSString *pwd = self.pwdTextField.textValue;
//    AccountData *accountData = [[AccountData alloc]init];
//    accountData.avatar = name;
//    accountData.pwd = pwd;
//    accountData.loginTime = [[NSDate date] timeIntervalSince1970];
//    LKDBHelper *lkdbHelper = [DBHelper getUsingLKDBHelper];
//    [lkdbHelper deleteWithClass:[AccountData class] where:[NSString stringWithFormat:@"avatar=%@",name] callback:^(BOOL result) {
//        
//        [lkdbHelper insertToDB:accountData];
//    }];
    
    HTAppContext *appContext = [HTAppContext sharedContext];
    appContext.uid = [response uid];
    [appContext save];
    HTUserData *userData = [HTUserData sharedInstance];
    userData.age = [response age];
    userData.avatar = [response avatar];
    userData.birthday = [response birthday];
    userData.coachTel = [response coachTel];
    //  userData.device = response.device;
    userData.height = [response height];
    userData.isCoach = [response isCoach];
    userData.nick = [response nick];
    userData.sex = [response sex];
    userData.tel = [response tel];
    userData.uid = [response uid];
    userData.isFresh = [response isFresh];
    [userData save];
    
    NSString *name = self.nameTextField.textValue;
    NSString *pwd = self.pwdTextField.textValue;
    AccountData *accountData = [[AccountData alloc]init];
    accountData.avatar = name;
    accountData.pwd = pwd;
    accountData.loginTime = [[NSDate date] timeIntervalSince1970];
    LKDBHelper *lkdbHelper = [DBHelper getUsingLKDBHelper];
    [lkdbHelper deleteWithClass:[AccountData class] where:[NSString stringWithFormat:@"avatar=%@",name] callback:^(BOOL result) {
        
        [lkdbHelper insertToDB:accountData];
    }];

    
  [APP_DELEGATE showHomeView];
}

#pragma mark - CheckCodeModelProtocol
- (void)checkCodeFinished:(BaseResponse *)response
{
  [self didTapAnywhere:nil];
  [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0) animated:YES];
}

- (void)privacyAction
{
    RegAgreementViewController *rega = [[RegAgreementViewController alloc] init];
    rega.type = 0;
    [self.navigationController pushViewController:rega animated:YES];
}

- (void)protocolAction
{
    RegAgreementViewController *rega = [[RegAgreementViewController alloc] init];
    rega.type = 1;
    [self.navigationController pushViewController:rega animated:YES];
}

- (void)randomAction
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"如果选择随机码注册，请谨记它注册成功后可用它登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self showHUD];
        [self.buildModel randomtel];
    }
}

- (void)syncFinished:(BuildvtelResponse *)response
{
    self.phoneTextField.text = response.vtel;
    [self hideHUD];
}

- (void)syncFailure
{
    [self hideHUD];
}

@end
