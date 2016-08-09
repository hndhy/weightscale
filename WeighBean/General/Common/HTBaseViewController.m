//
//  HTBaseViewController.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

#import <iToast/iToast.h>
#import "LoginViewController.h"
#import "HTNavigationController.h"

@interface HTBaseViewController ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation HTBaseViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.edgesForExtendedLayout = UIRectEdgeBottom;
  self.extendedLayoutIncludesOpaqueBars = NO;
  self.modalPresentationCapturesStatusBarAppearance = NO;
  self.view.backgroundColor = UIColorFromRGB(242.0f, 242.0f, 242.0f);
  [self initNavbar];
  [self initModel];
  [self initView];
  [self addNotification];
}

- (void)loadView
{
  [super loadView];
}

- (void)initNavbar
{
}

- (void)initModel
{
}

- (void)initView
{
}

- (void)addNotification
{
}

- (void)removeNotification
{
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//  HTNavigationBar *navBar = (HTNavigationBar *)self.navigationController.navigationBar;
//  [navBar changeBarStyle:_barStyle];
  [self.navigationController setNavigationBarHidden:self.hiddenNavigationBar animated:YES];
  NSUInteger count = [self.navigationController.viewControllers count];
  if (count > 1) {
    if (nil == self.navigationItem.leftBarButtonItem) {
      UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
      [backButton setImage:[UIImage imageNamed:@"black_nav_bar.png"] forState:UIControlStateNormal];
      [backButton addTarget:self action:@selector(onBackViewController:) forControlEvents:UIControlEventTouchUpInside];
      UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
      self.navigationItem.leftBarButtonItem = leftItem;
    }
  }
  if ([self needRefreshView]) {
    [self refreshView];
  }
}

- (BOOL)needRefreshView
{
  return NO;
}

- (void)clearView
{
}

- (void)refreshView
{
  [self clearView];
}

-(void)setTitle:(NSString *)title
{
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(0, 0, self.view.width, 44.0f)
                                        withSize:18.0f withColor:UIColorFromRGB(51.0f, 51.0f, 51.0f)];
  label.textColor = [UIColor whiteColor];
  label.text = title;
  [label sizeToFit];
  self.navigationItem.titleView = label;
}

- (void)backWithDelay:(int)delayTime
{
  [self performSelector:@selector(onBackViewController:) withObject:nil afterDelay:delayTime];
}

- (void)onBackViewController:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismiss
{
  [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)handleKeyboard
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardDidShow:)
                                               name:UIKeyboardDidShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)removeKeyboard
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
  self.animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
  [UIView animateWithDuration:_animationDuration animations:^{
  }];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  self.animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
  [UIView animateWithDuration:_animationDuration animations:NULL];
}

#pragma mark -  HUD Functions
- (void)showHUD
{
  [self showHUDWithLabel:@"加载数据"];
}

- (void)showHUDWithLabel:(NSString *)msg
{
  [self hideHUD];
  self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  self.hud.labelText = msg;
  [self.hud show:YES];
}

- (void)hideHUD
{
  if (self.hud) {
    [self.hud hide:YES afterDelay:0];
    self.hud = nil;
  }
}
- (void)hideHUDAfterDelay:(float)delay
{
    if (self.hud) {
        [self.hud hide:YES afterDelay:delay];
        self.hud = nil;
    }
}

#pragma mark - iToast Functions
- (void)showToast:(NSString *)msg
{
  [[iToast makeText:msg] show];
}

#pragma mark - ActionSheet Functions
- (void)showActionSheet:(NSString *)title
            cancelTitle:(NSString *)cancelTitle
       destructiveTitle:(NSString *)destructiveTitle
            otherTitles:(NSArray *)otherTitles
                    tag:(int)tag
{
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:destructiveTitle
                                                  otherButtonTitles:nil];
  actionSheet.tag = tag;
  for (NSString *otherTitle in otherTitles) {
    [actionSheet addButtonWithTitle:otherTitle];
  }
  if (cancelTitle) {
    [actionSheet addButtonWithTitle:cancelTitle];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
  }
  [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
  [actionSheet showInView:self.view];
}

#pragma mark - ActionSheetDelegate Functions
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
  for (UIView* subview in actionSheet.subviews) {
    if ([subview isKindOfClass:[UIButton class]]) {
      UIButton* button = (UIButton*)subview;
      button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
      button.titleLabel.textColor = [UIColor blackColor];
    } else if ([subview isKindOfClass:[UILabel class]]) {
      UILabel* label = (UILabel*)subview;
      label.textColor = [UIColor blackColor];
    }
  }
}

- (void)dealloc
{
  [self removeNotification];
}

#pragma mark -  MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
	[hud removeFromSuperview];
}

- (void)alert:(NSString *)title
      message:(NSString *)msg
     delegate:(id<UIAlertViewDelegate>)delegate
  cancelTitle:(NSString *)cancelTitle
  otherTitles:(NSString *)otherTitles
{
  UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                      message:msg
                                                     delegate:delegate
                                            cancelButtonTitle:cancelTitle
                                            otherButtonTitles:otherTitles,
                            nil];
  [alertView show];
}

- (BOOL)isLogin
{
  HTAppContext *appContext = [HTAppContext sharedContext];
  if (!ISEMPTY(appContext.uid)) {
    return YES;
  }
  return NO;
}

- (void)showLoginView
{
  [self showLoginView:self];
}

- (void)showLoginView:(id<LoginControllerProtocol>)delegate
{
  LoginViewController *loginViewController = [[LoginViewController alloc] init];
  loginViewController.hiddenNavigationBar = YES;
  HTNavigationController *loginNavController = [[HTNavigationController alloc] initWithRootViewController:loginViewController];
  //  loginViewController.delegate = self;
  [self presentViewController:loginNavController animated:YES completion:NULL];
}

- (void)handleModelError:(id)sender error:(NSError *)error
{
  if (2 == error.code) {
    // 用户权限过期
//    HHAppContext* appContext = [HHAppContext sharedContext];
//    appContext.uid = 0;
//    [appContext save];
    [self alert:@"用户验证失败"
                   message:[NSString stringWithFormat:@"用户验证失败，请重新登陆"]
                  delegate:nil
               cancelTitle:@"确定"
               otherTitles:nil];
  } else if (0 == error.code)
  {
      [self alert:@"成功"
          message:[NSString stringWithFormat:@"%@", error.domain]
         delegate:nil
      cancelTitle:@"确定"
      otherTitles:nil];

  } else {
    [self alert:@"出错了"
                   message:[NSString stringWithFormat:@"%@", error.domain]
                  delegate:nil
               cancelTitle:@"确定"
               otherTitles:nil];
  }
}

- (void)setTextAttributes:(HTTextField *)textField
{
  textField.hintColor = UIColorFromRGB(196.0f, 196.0f, 196.0f);
  textField.textColor = UIColorFromRGB(60.0f, 60.0f, 60.0f);
  textField.font = UIFontOfSize(15.0f);
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  textField.textAlignment = NSTextAlignmentLeft;
  textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

@end
