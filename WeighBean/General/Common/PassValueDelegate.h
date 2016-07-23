//
//  PassValueDelegate.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassValueDelegate <NSObject>

@required
- (void)passValue:(id)value type:(int)type;

@end
