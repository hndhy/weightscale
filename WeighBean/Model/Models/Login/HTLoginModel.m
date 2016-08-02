//
//  HTLoginModel.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTLoginModel.h"

@implementation HTLoginModel

- (void)loginWithName:(NSString *)name pwd:(NSString *)pwd
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:name forKey:@"nickOrTel"];
  [parameters setValue:pwd forKey:@"pwd"];
//  [self getPath:@"/login.htm" parameters:parameters];
    [self getPath:@"api/user/login" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
  return [[UserResponse alloc] initWithDictionary:responseDict error:error];
}

@end
