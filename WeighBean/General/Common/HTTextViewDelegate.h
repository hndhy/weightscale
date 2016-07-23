//
//  HTTextViewDelegate.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTScrollViewController;

@interface HTTextViewDelegate : NSObject<UITextViewDelegate>

@property (nonatomic, weak) HTScrollViewController* controller;

- (id)initWithScrollViewController:(HTScrollViewController*)controller;

@end
