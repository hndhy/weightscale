//
//  AppDelegate.h
//  WeighBean
//
//  Created by liumadu on 15/7/27.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL updated;

- (void)showIndexView;
- (void)showHomeView;

@end

