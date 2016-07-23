//
//  HTScrollViewController.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTScrollViewController.h"

@implementation HTScrollViewController

- (void)initNavbar
{
  [super initNavbar];
  self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                               initWithTarget:self
                               action:@selector(dismissKeyboard)];
  self.tapGestureRecognizer.enabled = NO;
  [self.view addGestureRecognizer:self.tapGestureRecognizer];
  self.textFieldDelegate = [[HTTextFieldDelegate alloc] initWithScrollViewController:self];
  self.textViewDelegate = [[HTTextViewDelegate alloc] initWithScrollViewController:self];
}

- (void)addNotification
{
  [self handleKeyboard];
}

-(void)dismissKeyboard
{
  if (self.activeView) {
    [self.activeView resignFirstResponder];
  }
  self.tapGestureRecognizer.enabled = NO;
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardDidShow:(NSNotification *)notification
{
  NSDictionary* info = [notification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
  
  // If active text field is hidden by keyboard, scroll it so it's visible
  // Your app might not need or want this behavior.
  CGRect rect = self.view.frame;
  rect.size.height -= kbSize.height;
  if (nil != self.activeView && !CGRectContainsPoint(rect, self.activeView.frame.origin) ) {
    [self.scrollView scrollRectToVisible:self.activeView.frame animated:YES];
  }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillHide:(NSNotification *)notification
{
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;
  self.scrollView.contentInset = contentInsets;
  self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)addTextField:(UITextField *)textField
{
  textField.delegate = self.textFieldDelegate;
  [self.scrollView addSubview:textField];
}

- (void)addTextView:(UITextView *)textView
{
  textView.delegate = self.textViewDelegate;
  [self.scrollView addSubview:textView];
}

- (void)returnFromTextField:(UITextField *)textField
{
  
}

- (BOOL)shouldChangeCharactersInRange:(UITextField*)textField range:(NSRange)range replacementString:(NSString *)string
{
  return YES;
}

@end
