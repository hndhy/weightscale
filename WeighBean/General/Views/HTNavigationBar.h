//
//  HTNavigationBar.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTBarStyle) {
  HTBarStyleDefault          = 0,
  HTBarStyleGreen             = 1
};

@interface HTNavigationBar : UINavigationBar

- (void)changeBarStyle:(HTBarStyle)barStyle;

@end
