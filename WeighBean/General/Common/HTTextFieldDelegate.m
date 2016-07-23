//
//  HTTextFieldDelegate.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTextFieldDelegate.h"
#import "HTScrollViewController.h"

@implementation HTTextFieldDelegate

- (id)initWithScrollViewController:(HTScrollViewController *)controller
{
  self = [super init];
  if (self) {
    self.controller = controller;
  }
  return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  self.controller.tapGestureRecognizer.enabled = YES;
  return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  self.controller.activeView = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  self.controller.activeView = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [self.controller returnFromTextField:textField];
  return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  return [self.controller shouldChangeCharactersInRange:textField range:range replacementString:string];
}

@end
