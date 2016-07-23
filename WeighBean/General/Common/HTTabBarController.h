//
//  HTBaseTabBarController.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTTabBarController : UIViewController

@property (nonatomic,copy) void(^setTopBlock)(void);
@property (nonatomic,copy) void(^setOtherTopBlock)(void);
@property (nonatomic,copy) BOOL(^isCanBackBlock)(void);

- (void)addViewController:(UIViewController *)viewController;
- (void)showControllerWithTag:(NSInteger)tag;

@end
