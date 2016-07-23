//
//  HTTextField.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTTextField : UITextField
{
  UILabel *_hintLabel;
}

@property (nonatomic, strong) NSString *hint;
@property (nonatomic, strong) UIColor   *hintColor;
@property (nonatomic, strong) NSString *textValue;

@end
