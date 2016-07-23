//
//  HTAppContext.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTAppContext : NSObject

// 是否运行过导航页面
@property (nonatomic, assign) BOOL guideRun;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *ads;
@property (nonatomic, strong) NSString *home;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, assign) BOOL isOpenWiFi;
@property (nonatomic, strong) NSString *messageCount;

+ (instancetype)sharedContext;
- (void)save;
- (void)saveDevice;
- (void)saveAdsInfo;
- (void)saveHomeInfo;
- (void)clear;
+ (BOOL)isLogin;
- (void)saveIsOpen;
- (NSString *)openString;
@end
