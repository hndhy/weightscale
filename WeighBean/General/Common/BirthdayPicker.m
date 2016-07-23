//
//  BirthdayPicker.m
//  WeighBean
//
//  Created by liumadu on 15/8/11.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BirthdayPicker.h"

#import "UIView+Ext.h"
#import "UILabel+Ext.h"
#import "UtilsMacro.h"
#import "NSDate+Utilities.h"

static const NSTimeInterval kAnimationDuration = 0.33;

@interface BirthdayPicker ()

@property (nonatomic, readonly, weak) UIViewController<BirthdayPickerProtocol> *controller;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIDatePicker *picker;

@end

@implementation BirthdayPicker

- (id)initWithController:(UIViewController<BirthdayPickerProtocol> *)controller
{
  self = [super init];
  if (self) {
    _controller = controller;
    [self initSubViews];
  }
  return self;
}

- (void)initSubViews
{
  UIWindow *window = self.controller.view.window;
  self.popView = [[UIView alloc] initWithFrame:window.frame];
  [self.popView addTapCallBack:self sel:@selector(onCloseClick:)];
  self.popView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
  self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.popView.bottom, self.popView.width, 44.0f)];
  self.titleView.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
  [self.popView addSubview:self.titleView];
  UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(self.titleView.width - 88.0f, 0, 88.0f, 44.0f)];
  confirmButton.titleLabel.font = UIFontOfSize(14.0f);
  [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
  [confirmButton addTarget:self action:@selector(onConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.titleView addSubview:confirmButton];
  UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88.0f, 44.0f)];
  cancelButton.titleLabel.font = UIFontOfSize(14.0f);
  [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
  [cancelButton addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
  [self.titleView addSubview:cancelButton];
  self.picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.titleView.bottom, self.popView.width, 162.0f)];
  [self.picker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
  self.picker.datePickerMode = UIDatePickerModeDate;
  self.picker.backgroundColor = [UIColor whiteColor];
  [self.popView addSubview:self.picker];
}

- (void)showBirthdayPicker
{
  UIWindow *window = self.controller.view.window;
  [window addSubview:self.popView];
  [UIView animateWithDuration:kAnimationDuration * 0.8
                        delay:kAnimationDuration * 0.2
                      options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone
                   animations:^{
                     self.titleView.top = self.popView.height - 44.0f - 162.0;
                     self.picker.top = self.titleView.bottom;
                   } completion:NULL];
}

- (void)hidePickerView
{
  [UIView animateWithDuration:kAnimationDuration * 0.8
                        delay:kAnimationDuration * 0.2
                      options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone
                   animations:^{
                     self.titleView.top = self.popView.bottom;
                     self.picker.top = self.titleView.bottom;
                   } completion:^(BOOL finished) {
                     [self.popView removeFromSuperview];
                   }];
}

- (void)onConfirmClick:(id)sender
{
  [self hidePickerView];
  if ([self.controller respondsToSelector:@selector(selectedBirthday:time:)]) {
    NSString *dateStr = [self.picker.date stringWithFormat:@"yyyy年MM月dd日"];
    NSString *time = [self.picker.date stringWithFormat:@"yyyyMMdd"];
    [self.controller selectedBirthday:dateStr time:time];
  }
}

- (void)onCloseClick:(id)button
{
  if (self.popView && self.popView.superview) {
    [self.popView removeFromSuperview];
  }
}

@end
