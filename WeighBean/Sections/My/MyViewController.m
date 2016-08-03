//
//  MyViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/9.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "MyViewController.h"
#import <RESideMenu.h>
#import <UIImageView+WebCache.h>
#import "NSDate+Utilities.h"
#import "PicturePicker.h"
#import "HeightPicker.h"
#import "BirthdayPicker.h"

#import "HTUpdateInfoModel.h"
#import "UpdateInfoModelHandler.h"
#import "HTMyInfoModel.h"
#import "MyInfoModelHandler.h"
#import "UpLoadAvatarModel.h"
#import "UploadAvatarModelHandler.h"

#import "AppDelegate.h"
#import "MiPushSDK.h"

@interface MyViewController ()<PicturePickerProtocol, HeightPickerProtocol, BirthdayPickerProtocol, UpdateInfoModelProtocol, MyInfoModelProtocol, UploadAvatarModelProtocol>

@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *heightLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *birthdayLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, assign) BOOL isSave;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) PicturePicker *picturePicker;
@property (nonatomic, strong) NSString *heightStr;
@property (nonatomic, strong) HeightPicker *heightPicker;
@property (nonatomic, assign) int sex;
@property (nonatomic, strong) BirthdayPicker *birthdayPicker;
@property (nonatomic, strong) NSString *birthdayStr;

@property (nonatomic, strong) HTUpdateInfoModel *updateInfoModel;
@property (nonatomic, strong) UpdateInfoModelHandler *updateInfoModelHandler;
@property (nonatomic, strong) HTMyInfoModel *myInfoModel;
@property (nonatomic, strong) MyInfoModelHandler *myInfoModelHandler;
@property (nonatomic, strong) UpLoadAvatarModel *upLoadAvatarModel;
@property (nonatomic, strong) UploadAvatarModelHandler *uploadAvatarModelHandler;

@end

@implementation MyViewController

- (void)initNavbar
{
  self.title = @"个人资料";
  UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
  [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
  [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
  self.navigationItem.leftBarButtonItem = leftItem;
  self.editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 44.0f)];
  [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
  [self.editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  self.editButton.titleLabel.font = UIFontOfSize(15.0f);
  [self.editButton addTarget:self action:@selector(onEditClick:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
  self.navigationItem.rightBarButtonItem = item;
}

- (void)initModel
{
  self.updateInfoModelHandler = [[UpdateInfoModelHandler alloc] initWithController:self];
  self.updateInfoModel = [[HTUpdateInfoModel alloc] initWithHandler:self.updateInfoModelHandler];
  self.myInfoModelHandler = [[MyInfoModelHandler alloc] initWithController:self];
  self.myInfoModel = [[HTMyInfoModel alloc] initWithHandler:self.myInfoModelHandler];
  self.uploadAvatarModelHandler = [[UploadAvatarModelHandler alloc] initWithController:self];
  self.upLoadAvatarModel = [[UpLoadAvatarModel alloc] initWithHandler:self.uploadAvatarModelHandler];
}

- (void)initView
{
  HTUserData *userData = [HTUserData sharedInstance];
  UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15.0f, 0, self.view.width - 15.0f, 30.0f)
                                             withSize:12.0f withColor:UIColorFromRGB(120.0f, 120.0f, 120.0f)];
  titleLabel.text = @"个人详细信息";
  [self.view addSubview:titleLabel];
  UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(-0.5f, titleLabel.bottom, self.view.width + 1.0f, 105.0f)];
  firstView.layer.borderColor = UIColorFromRGB(211.0f, 211.0f, 211.0f).CGColor;
  firstView.layer.borderWidth = 0.5f;
  firstView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:firstView];
  UILabel *avatarLabel = [UILabel createLabelWithFrame:CGRectMake(15.0f, firstView.top, firstView.width - 15.0f, 62.0f)
                                              withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
  avatarLabel.text = @"头像";
  [self.view addSubview:avatarLabel];
  self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(firstView.width - 62.0f, firstView.top + 8.0f, 46.0f, 46.0f)];
  self.avatarImageView.layer.cornerRadius = 23.0f;
  self.avatarImageView.layer.masksToBounds = YES;
  self.avatarImageView.backgroundColor = UIColorFromRGB(126.0f, 206.0f, 244.0f);
  [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userData.avatar]];
  [self.avatarImageView addTapCallBack:self sel:@selector(updateAvatarClick:)];
  [self.view addSubview:self.avatarImageView];
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(avatarLabel.left, avatarLabel.bottom, avatarLabel.width, 0.5f)];
  lineView.backgroundColor = UIColorFromRGB(211.0f, 211.0f, 211.0f);
  [self.view addSubview:lineView];
  UILabel *nameTitleLabel = [UILabel createLabelWithFrame:CGRectMake(lineView.left, lineView.bottom, lineView.width - 16.0f, 43.0f)
                                              withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
  nameTitleLabel.text = @"用户名";
  [self.view addSubview:nameTitleLabel];
  self.nameLabel = [UILabel createLabelWithFrame:nameTitleLabel.frame withSize:14.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  self.nameLabel.textAlignment = NSTextAlignmentRight;
  self.nameLabel.text = userData.nick;
  [self.nameLabel addTapCallBack:self sel:@selector(onNameClick:)];
  [self.view addSubview:self.nameLabel];
  UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(-0.5f, firstView.bottom + 6.0f, firstView.width, 130.0f)];
  secondView.layer.borderColor = UIColorFromRGB(211.0f, 211.0f, 211.0f).CGColor;
  secondView.layer.borderWidth = 0.5f;
  secondView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:secondView];
  UILabel *heightTitleLabel = [UILabel createLabelWithFrame:CGRectMake(self.nameLabel.left, secondView.top, self.nameLabel.width, 43.0f)
                                                 withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
  heightTitleLabel.text = @"身高";
  [self.view addSubview:heightTitleLabel];
  self.heightLabel = [UILabel createLabelWithFrame:heightTitleLabel.frame withSize:14.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  self.heightLabel.textAlignment = NSTextAlignmentRight;
  self.heightLabel.text = [NSString stringWithFormat:@"%d厘米", userData.height];
  [self.heightLabel addTapCallBack:self sel:@selector(onHeightClick:)];
  [self.view addSubview:self.heightLabel];
  lineView = [[UIView alloc] initWithFrame:CGRectMake(avatarLabel.left, heightTitleLabel.bottom, avatarLabel.width, 0.5f)];
  lineView.backgroundColor = UIColorFromRGB(211.0f, 211.0f, 211.0f);
  [self.view addSubview:lineView];
  UILabel *sexTitleLabel = [UILabel createLabelWithFrame:CGRectMake(self.nameLabel.left, lineView.bottom, self.nameLabel.width, 43.0f)
                                                   withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
  sexTitleLabel.text = @"性别";
  [self.view addSubview:sexTitleLabel];
  self.sexLabel = [UILabel createLabelWithFrame:sexTitleLabel.frame withSize:14.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  self.sexLabel.textAlignment = NSTextAlignmentRight;
  self.sex = userData.sex;
  if (0 == self.sex) {
    self.sexLabel.text = @"女";
  } else {
    self.sexLabel.text = @"男";
  }
  [self.sexLabel addTapCallBack:self sel:@selector(onSexClick:)];
  [self.view addSubview:self.sexLabel];
  lineView = [[UIView alloc] initWithFrame:CGRectMake(avatarLabel.left, sexTitleLabel.bottom, avatarLabel.width, 0.5f)];
  lineView.backgroundColor = UIColorFromRGB(211.0f, 211.0f, 211.0f);
  [self.view addSubview:lineView];
  UILabel *birthdayTitleLabel = [UILabel createLabelWithFrame:CGRectMake(self.nameLabel.left, lineView.bottom, self.nameLabel.width, 43.0f)
                                                withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
  birthdayTitleLabel.text = @"出生日期";
  [self.view addSubview:birthdayTitleLabel];
  self.birthdayLabel = [UILabel createLabelWithFrame:birthdayTitleLabel.frame withSize:14.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  self.birthdayLabel.textAlignment = NSTextAlignmentRight;
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyyMMdd"];
  NSDate *date = [dateFormatter dateFromString:userData.birthday];
  [self.birthdayLabel addTapCallBack:self sel:@selector(onBirthdayClick:)];
  self.birthdayLabel.text = [NSString stringWithFormat:@"%@", [date stringWithFormat:@"yyyy-MM-dd"]];
  [self.view addSubview:self.birthdayLabel];
  UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(-0.5f, secondView.bottom + 6.0f, self.view.width + 1.0f, 43.0f)];
  thirdView.layer.borderColor = UIColorFromRGB(211.0f, 211.0f, 211.0f).CGColor;
  thirdView.layer.borderWidth = 0.5f;
  thirdView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:thirdView];
  UILabel *phoneTitleLabel = [UILabel createLabelWithFrame:CGRectMake(self.nameLabel.left, thirdView.top, self.nameLabel.width, 43.0f)
                                                     withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
  phoneTitleLabel.text = @"V教练";
  [self.view addSubview:phoneTitleLabel];
  self.phoneLabel = [UILabel createLabelWithFrame:phoneTitleLabel.frame withSize:14.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  self.phoneLabel.textAlignment = NSTextAlignmentRight;
  self.phoneLabel.text = userData.coachTel;
  [self.phoneLabel addTapCallBack:self sel:@selector(onCoachTelClick:)];
  [self.view addSubview:self.phoneLabel];
  UIView *fourthView = [[UIView alloc] initWithFrame:CGRectMake(-0.5f, thirdView.bottom + 6.0f, thirdView.width, 43.0f)];
  fourthView.layer.borderColor = UIColorFromRGB(211.0f, 211.0f, 211.0f).CGColor;
  fourthView.layer.borderWidth = 0.5f;
  fourthView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:fourthView];
    
  UILabel *numTitleLabel = [UILabel createLabelWithFrame:CGRectMake(self.nameLabel.left, fourthView.top, self.nameLabel.width, 43.0f)
                                                  withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
  numTitleLabel.text = @"设备号";
  [self.view addSubview:numTitleLabel];
  self.numLabel = [UILabel createLabelWithFrame:numTitleLabel.frame withSize:14.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  self.numLabel.textAlignment = NSTextAlignmentRight;
  HTAppContext *appContext = [HTAppContext sharedContext];
  self.numLabel.text = appContext.device;
  [self.numLabel addTapCallBack:self sel:@selector(onNumClick:)];
  [self.view addSubview:self.numLabel];
    
    /*
    UIView *switchView = [[UIView alloc] initWithFrame:CGRectMake(-0.5f, fourthView.bottom + 6.0f, fourthView.width, 43.0f)];
    switchView.layer.borderColor = UIColorFromRGB(211.0f, 211.0f, 211.0f).CGColor;
    switchView.layer.borderWidth = 0.5f;
    switchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:switchView];
    
    UILabel *wifiTitleLabel = [UILabel createLabelWithFrame:CGRectMake(numTitleLabel.left, numTitleLabel.bottom + 6.0, self.nameLabel.width, 43.0f)
                                                  withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
    wifiTitleLabel.text = @"WiFi秤开关";
    [self.view addSubview:wifiTitleLabel];
    
    UISwitch *switchWiFi = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.width - 60, wifiTitleLabel.top + 5, 50, 33)];
    [switchWiFi addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchWiFi];
    
    switchWiFi.on = appContext.isOpenWiFi;
    */

  UIView *fifthView = [[UIView alloc] initWithFrame:CGRectMake(-0.5f, numTitleLabel.bottom + 6.0f, thirdView.width, 43.0f)];
  fifthView.layer.borderColor = UIColorFromRGB(211.0f, 211.0f, 211.0f).CGColor;
  fifthView.layer.borderWidth = 0.5f;
  fifthView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:fifthView];
  UILabel *exitTitleLabel = [UILabel createLabelWithFrame:CGRectMake(self.nameLabel.left, fifthView.top, self.nameLabel.width, 43.0f)
                                                withSize:16.0f withColor:UIColorFromRGB(16.0f, 17.0f, 17.0f)];
  exitTitleLabel.text = @"退出";
  [exitTitleLabel addTapCallBack:self sel:@selector(onExitClick:)];
  [self.view addSubview:exitTitleLabel];
  [self showHUDWithLabel:@"更新用户信息"];
  [self.myInfoModel getMyInfo:userData.uid];
}

- (void)switchAction:(UISwitch *)swit
{
    HTAppContext *appContext = [HTAppContext sharedContext];
    appContext.isOpenWiFi = swit.on;
    [appContext saveIsOpen];
}

- (void)onEditClick:(UIButton *)sender
{
  if (!self.isSave) {
    [sender setTitle:@"保存" forState:UIControlStateNormal];
    self.isSave = YES;
  } else {
    HTUserData *userData = [HTUserData sharedInstance];
    NSString *name = self.nameLabel.text;
    if (ISEMPTY(name)) {
      [self showToast:@"请输入用户名"];
      return;
    }
//    UIImage *image = nil;
//    if (self.avatar) {
//      image = self.avatar;
//    } else if (self.avatarImageView.image) {
//      image = self.avatarImageView.image;
//    } else {
//      [self showToast:@"请设置您的头像"];
//      return;
//    }
    NSString *coachTel = self.phoneLabel.text;
    if (ISEMPTY(coachTel)) {
      [self showToast:@"请输入V教练电话"];
      return;
    }
    if (coachTel.length < 7) {
      [self showToast:@"您输入的手机号位数不对"];
      return;
    }
    NSString *device = self.numLabel.text;
    if (/*ISEMPTY(device)*/device.length<6&&device.length) {
      [self showToast:@"请输入6位或6位以上设备号"];
      return;
    }
    if (device.length >= 6) {
      NSString *subDev = [device substringWithRange:NSMakeRange(device.length-6, 6)];
      HTAppContext *appContext = [HTAppContext sharedContext];
      appContext.device = [NSString stringWithFormat:@"HYD-%@",subDev];
      [appContext saveDevice];
    }
    
    [self showHUDWithLabel:@"正在上传修改数据"];
    NSString *tmpAvatarUrl = @"";
    if (!ISEMPTY(self.avatarUrl)) {
      tmpAvatarUrl = self.avatarUrl;
    } else if (!ISEMPTY(userData.avatar)) {
      tmpAvatarUrl = userData.avatar;
    }
    [self.updateInfoModel updateInfo:userData.uid name:name avatar:tmpAvatarUrl height:self.heightStr sex:self.sex birthday:self.birthdayStr device:device coachTel:coachTel];
  }
}

- (void)updateAvatarClick:(id)sender
{
  if (!self.isSave) {
    return;
  }
  if (nil == self.picturePicker) {
    self.picturePicker = [[PicturePicker alloc] initWithController:self];
    self.picturePicker.type = PicturePickerAvatar;
  }
  [self.picturePicker showActionSheet:nil];
}

- (void)onNameClick:(id)sender
{
  if (!self.isSave) {
    return;
  }
  [self showEditAlert:@"修改用户名" tag:1];
}

- (void)onHeightClick:(id)sender
{
  if (!self.isSave) {
    return;
  }
  if (nil == self.heightPicker) {
    self.heightPicker = [[HeightPicker alloc] initWithController:self];
  }
  [self.heightPicker showHeightPicker];
}

- (void)onSexClick:(UITapGestureRecognizer *)recognizer
{
  if (!self.isSave) {
    return;
  }
  NSString *sexStr = self.sexLabel.text;
  if ([@"男" isEqualToString:sexStr]) {
    self.sex = 0;
    self.sexLabel.text = @"女";
  } else {
    self.sex = 1;
    self.sexLabel.text = @"男";
  }
}

- (void)onBirthdayClick:(id)sender
{
  if (!self.isSave) {
    return;
  }
  if (nil == self.birthdayPicker) {
    self.birthdayPicker = [[BirthdayPicker alloc] initWithController:self];
  }
  [self.birthdayPicker showBirthdayPicker];
}

- (void)onCoachTelClick:(id)sender
{
  if (!self.isSave) {
    return;
  }
  [self showEditAlert:@"V教练电话" tag:3];
}

- (void)onNumClick:(id)sender
{
  if (!self.isSave) {
    return;
  }
  [self showEditAlert:@"修改设备号" tag:2];
}

- (void)showEditAlert:(NSString *)title tag:(int)tag
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                  message:@""
                                                 delegate:self
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确定", nil];
  alert.alertViewStyle = UIAlertViewStylePlainTextInput;
  alert.tag = tag;
  [alert show];
}

- (void)onExitClick:(id)sender
{
  HTAppContext *appContext = [HTAppContext sharedContext];
  appContext.uid = @"-1";
  [appContext save];
  HTUserData *userData = [HTUserData sharedInstance];
    [MiPushSDK unsetAlias:userData.uid];
  userData.uid = @"-1";
  [userData save];
  APP_DELEGATE.updated = NO;
  [APP_DELEGATE showIndexView];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (1 == buttonIndex) {
    int tag = (int)alertView.tag;
    if (1 == tag) {
      self.nameLabel.text = [alertView textFieldAtIndex:0].text;
    } else if (2 == tag) {
      self.numLabel.text = [alertView textFieldAtIndex:0].text;
    } else if (3 == tag) {
      self.phoneLabel.text = [alertView textFieldAtIndex:0].text;
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


#pragma mark - HeightPickerProtocol
- (void)selectHeight:(NSString *)height
{
  self.heightStr = height;
  self.heightLabel.text = [NSString stringWithFormat:@"%@厘米", height];
}

#pragma mark - BirthdayPickerProtocol
- (void)selectedBirthday:(NSString *)birthday time:(NSString *)time
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyyMMdd"];
  NSDate *date = [dateFormatter dateFromString:time];
  self.birthdayLabel.text = [NSString stringWithFormat:@"%@", [date stringWithFormat:@"yyyy-MM-dd"]];
  self.birthdayStr = time;
}

#pragma mark - UpdateInfoModelProtocol
- (void)updateInfoFinished:(UserResponse *)response
{
  [self showToast:@"修改数据成功"];
  self.isSave = NO;
  self.avatarUrl = nil;
  [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
//  HTAppContext *appContext = [HTAppContext sharedContext];
//  appContext.uid = response.uid;
//  [appContext save];
//  HTUserData *userData = [HTUserData sharedInstance];
//  userData.isFresh = response.isFresh;
//  userData.age = response.age;
//  userData.avatar = response.avatar;
//  userData.birthday = response.birthday;
//  userData.coachTel = response.coachTel;
////  userData.device = response.device;
//  userData.height = response.height;
//  userData.isCoach = response.isCoach;
//  userData.nick = response.nick;
//  self.sex = response.sex;
//  userData.sex = response.sex;
//  userData.tel = response.tel;
//  userData.uid = response.uid;
//  [userData save];
    
    
    HTAppContext *appContext = [HTAppContext sharedContext];
    appContext.uid = [response uid];
    [appContext save];
    HTUserData *userData = [HTUserData sharedInstance];
    userData.isFresh = [response isFresh];
    userData.age = [response age];
    userData.avatar = [response avatar];
    userData.birthday = [response birthday];
    userData.coachTel = [response coachTel];
    //  userData.device = response.device;
    userData.height = [response height];
    userData.isCoach = [response isCoach];
    userData.nick = [response nick];
    self.sex = [response sex];
    userData.sex = [response sex];
    userData.tel = [response tel];
    userData.uid = [response uid];
    [userData save];

    
  [NotificationCenter postModifyInfoNotification];
}

#pragma mark - MyInfoModelProtocol
- (void)myInfoFinished:(UserResponse *)response
{
//  HTAppContext *appContext = [HTAppContext sharedContext];
//  appContext.uid = response.uid;
//  [appContext save];
//  HTUserData *userData = [HTUserData sharedInstance];
//  userData.isFresh = response.isFresh;
//  userData.age = response.age;
//  userData.avatar = response.avatar;
//  userData.birthday = response.birthday;
//  userData.coachTel = response.coachTel;
////  userData.device = response.device;
//  userData.height = response.height;
//  userData.isCoach = response.isCoach;
//  userData.nick = response.nick;
//  userData.sex = response.sex;
//  userData.tel = response.tel;
//  userData.uid = response.uid;
//  [userData save];
//  [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userData.avatar]];
//  self.nameLabel.text = userData.nick;
//  self.heightLabel.text = [NSString stringWithFormat:@"%d厘米", userData.height];
//  self.sex = userData.sex;
//  if (0 == self.sex) {
//    self.sexLabel.text = @"女";
//  } else {
//    self.sexLabel.text = @"男";
//  }
//  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//  [dateFormatter setDateFormat:@"yyyyMMdd"];
//  NSDate *date = [dateFormatter dateFromString:userData.birthday];
//  [self.birthdayLabel addTapCallBack:self sel:@selector(onBirthdayClick:)];
//  self.birthdayLabel.text = [NSString stringWithFormat:@"%@", [date stringWithFormat:@"yyyy-MM-dd"]];
//  self.phoneLabel.text = userData.coachTel;
    
    
    HTAppContext *appContext = [HTAppContext sharedContext];
    appContext.uid = [response uid];
    [appContext save];
    HTUserData *userData = [HTUserData sharedInstance];
    userData.isFresh = [response isFresh];
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
    [userData save];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userData.avatar]];
    self.nameLabel.text = userData.nick;
    self.heightLabel.text = [NSString stringWithFormat:@"%d厘米", userData.height];
    self.sex = userData.sex;
    if (0 == self.sex) {
        self.sexLabel.text = @"女";
    } else {
        self.sexLabel.text = @"男";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormatter dateFromString:userData.birthday];
    [self.birthdayLabel addTapCallBack:self sel:@selector(onBirthdayClick:)];
    self.birthdayLabel.text = [NSString stringWithFormat:@"%@", [date stringWithFormat:@"yyyy-MM-dd"]];
    self.phoneLabel.text = userData.coachTel;

    
    
    
  [NotificationCenter postModifyInfoNotification];
}

@end
