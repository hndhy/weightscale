//
//  SharePlat.h
//  WeighBean
//
//  Created by liumadu on 15/8/9.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol SharePlatDelegate <NSObject>

@required
- (void)gotoTrend;
- (void)sendSMS:(UIImage *)image;

@end

@interface SharePlat : NSObject

@property (nonatomic, weak) id<SharePlatDelegate> delegate;
@property (nonatomic, assign) BOOL showTrend;


+ (instancetype)sharedInstance;
- (void)showShareActionSheet;

@end
