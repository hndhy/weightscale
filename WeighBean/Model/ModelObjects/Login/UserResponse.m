//
//  UserResponse.m
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UserResponse.h"

@implementation UserResponse

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  if ([@"isFresh" isEqualToString:propertyName]) {
    return YES;
  }
  return NO;
}

@end
