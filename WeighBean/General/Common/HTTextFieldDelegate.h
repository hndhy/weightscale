//
//  HTTextFieldDelegate.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HTScrollViewController;

@interface HTTextFieldDelegate : NSObject<UITextFieldDelegate>

@property (nonatomic, weak) HTScrollViewController* controller;

- (id)initWithScrollViewController:(HTScrollViewController*)controller;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
