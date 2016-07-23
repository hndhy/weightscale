//
//  HTApiClient.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface HTApiClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

- (BOOL)isNetworkAvailable;

@end