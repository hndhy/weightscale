//
//  HTScrollViewController.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "HTTextFieldDelegate.h"
#import "HTTextViewDelegate.h"

@interface HTScrollViewController : HTBaseViewController

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) HTTextFieldDelegate* textFieldDelegate;
@property (nonatomic, strong) HTTextViewDelegate* textViewDelegate;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* activeView; // 当前处于焦点的view

- (void)addTextField:(UITextField*)textField;
- (void)addTextView:(UITextView *)textView;
- (void)returnFromTextField:(UITextField*)textField;
- (BOOL)shouldChangeCharactersInRange:(UITextField*)textField range:(NSRange)range replacementString:(NSString *)string;

@end
