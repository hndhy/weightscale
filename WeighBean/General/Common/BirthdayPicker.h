//
//  BirthdayPicker.h
//  WeighBean
//
//  Created by liumadu on 15/8/11.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol BirthdayPickerProtocol <NSObject>
@required
- (void)selectedBirthday:(NSString *)birthday time:(NSString *)time;

@end

@interface BirthdayPicker : NSObject

- (id)initWithController:(UIViewController<BirthdayPickerProtocol> *)controller;
- (void)showBirthdayPicker;

@end
