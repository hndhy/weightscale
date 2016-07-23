//
//  ClockInViewController.h
//  WeighBean
//
//  Created by liumadu on 15/8/11.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface ClockInViewController : HTBaseViewController


@property (nonatomic, strong) NSString *actionName;

@property (nonatomic, strong) NSString *clockUid;

@property (nonatomic, assign) UIViewController *top;

- (void)refreshWeb;

- (void)questionAction;

@end
