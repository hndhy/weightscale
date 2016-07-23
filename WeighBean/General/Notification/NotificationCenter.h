//
//  NotificationCenter.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationCenter : NSObject

+ (void)addModifyInfoObserver:(id)observer selector:(SEL)selector object:(id)object;
+ (void)postModifyInfoNotification;
+ (void)removeModifyInfoObserver:(id)observer object:(id)object;

@end
