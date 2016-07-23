//
//  NotificationCenter.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "NotificationCenter.h"

static NSString *const ModifyInfoNotificationName = @"modify_info_notification";

@implementation NotificationCenter

+ (void)addModifyInfoObserver:(id)observer selector:(SEL)selector object:(id)object
{
  [[NSNotificationCenter defaultCenter] addObserver:observer
                                           selector:selector
                                               name:ModifyInfoNotificationName
                                             object:object];
}

+ (void)postModifyInfoNotification
{
  [[NSNotificationCenter defaultCenter] postNotificationName:ModifyInfoNotificationName
                                                      object:nil
                                                    userInfo:nil];
}

+ (void)removeModifyInfoObserver:(id)observer object:(id)object
{
  [[NSNotificationCenter defaultCenter] removeObserver:observer name:ModifyInfoNotificationName object:object];
}

@end
