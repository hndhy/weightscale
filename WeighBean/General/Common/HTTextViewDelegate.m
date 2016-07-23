//
//  HTTextViewDelegate.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTextViewDelegate.h"
#import "HTScrollViewController.h"

@implementation HTTextViewDelegate

- (id)initWithScrollViewController:(HTScrollViewController *)controller
{
  self = [super init];
  if (self) {
    self.controller = controller;
  }
  return self;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
  self.controller.tapGestureRecognizer.enabled = YES;
  return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
  self.controller.activeView = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
  self.controller.activeView = nil;
}


@end
