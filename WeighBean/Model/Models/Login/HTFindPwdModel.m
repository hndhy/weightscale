//
//  HTFindPwdModel.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTFindPwdModel.h"

@implementation HTFindPwdModel

- (void)findPwdWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:phone forKey:@"tel"];
  [parameters setValue:code forKey:@"qcode"];
  [parameters setValue:pwd forKey:@"pwd"];
  [self getPath:@"/changepwd.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
  return [[UserResponse alloc] initWithDictionary:responseDict error:error];
}

@end
