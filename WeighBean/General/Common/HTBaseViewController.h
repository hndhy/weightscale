//
//  HTBaseViewController.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppMacro.h"
#import "UtilsMacro.h"
#import "VersionMacro.h"
#import "UIView+Ext.h"
#import "HTTextField.h"
#import "UILabel+Ext.h"

#import <MBProgressHUD.h>

#import "HTAppContext.h"
#import "HTUserData.h"
#import "NotificationCenter.h"
#import "LoginControllerProtocol.h"
#import "HTNavigationBar.h"

@interface HTBaseViewController : UIViewController<MBProgressHUDDelegate, UIActionSheetDelegate, LoginControllerProtocol>

@property (nonatomic, assign) float animationDuration;
@property(nonatomic, assign) BOOL hiddenNavigationBar;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) HTBarStyle barStyle;

- (void)initNavbar; // called in viewDidLoad, need to be reimplemented
- (void)initModel;  // called in viewDidLoad, need to be reimplemented
- (void)initView;   // called in viewDidLoad, need to be reimplemented
- (void)addNotification; // called in viewDidLoad, need to be reimplemented
- (void)removeNotification; // called in dealloc, need to be reimplemented
- (BOOL)needRefreshView; // called in viewDidAppear, need to be reimplemented
- (void)clearView; // called in refreshView, need to be reimplemented
- (void)refreshView; // called in viewDidAppear, need to be reimplemented

// utility functions
- (void)handleKeyboard;
- (void)removeKeyboard;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

// hud functions
- (void)showHUD;
- (void)showHUDWithLabel:(NSString *)msg;
- (void)hideHUD;
- (void)hideHUDAfterDelay:(float)delay;
// itoast functions
- (void)showToast:(NSString*)msg;

// action sheet functions
- (void)showActionSheet:(NSString *)title
            cancelTitle:(NSString *)cancelTitle
       destructiveTitle:(NSString *)destructiveTitle
            otherTitles:(NSArray*) otherTitles
                    tag:(int)tag;

// back and alert functions
- (void)backWithDelay:(int)delayTime;
- (void)onBackViewController:(id)sender;
- (void)dismiss;
- (void)alert:(NSString *)title
      message:(NSString *)msg
     delegate:(id<UIAlertViewDelegate>)delegate
  cancelTitle:(NSString *)cancelTitle
  otherTitles:(NSString *)otherTitles;

- (void)showLoginView;
- (void)showLoginView:(id<LoginControllerProtocol>)delegate;
- (void)handleModelError:(id)sender error:(NSError*)error;

- (void)setTextAttributes:(UITextField *)textField;

@end


