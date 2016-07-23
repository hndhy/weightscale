//
//  QHistoryViewController.h
//  WeighBean
//
//  Created by 曾宪东 on 15/12/12.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface QHistoryViewController : HTBaseViewController

@property (nonatomic,assign) BOOL isOpenSide;

@property (nonatomic,strong) UINavigationController *nav;

- (void)onAddClick;

- (BOOL)isCanBack;

@end
