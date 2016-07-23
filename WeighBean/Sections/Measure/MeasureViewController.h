//
//  MeasureViewController.h
//  WeighBean
//
//  Created by liumadu on 15/8/8.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

#import "PassValueDelegate.h"

@interface MeasureViewController : HTBaseViewController

@property (nonatomic, assign) id<PassValueDelegate> delegate;
@property (nonatomic, strong) NSArray *array;

@end
