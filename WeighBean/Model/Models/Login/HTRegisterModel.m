//
//  HTRegisterModel.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTRegisterModel.h"

@implementation HTRegisterModel

- (void)registerWithNick:(NSString *)nick pwd:(NSString *)pwd height:(NSString *)height sex:(int)sex birthday:(NSString *)birthday tel:(NSString *)tel coachTel:(NSString *)coachTel avatar:(NSString *)avatar device:(NSString *)device
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:nick forKey:@"nick"];
  [parameters setValue:pwd forKey:@"pwd"];
  [parameters setValue:height forKey:@"height"];
  [parameters setValue:[NSNumber numberWithInt:sex] forKey:@"sex"];
  [parameters setValue:birthday forKey:@"birthday"];
  [parameters setValue:tel forKey:@"tel"];
  [parameters setValue:coachTel forKey:@"coachTel"];
  [parameters setValue:avatar forKey:@"avatar"];
  [parameters setValue:@"" forKey:@"device"];
  [self getPath:@"/reg.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
  return [[UserResponse alloc] initWithDictionary:responseDict error:error];
}

@end
