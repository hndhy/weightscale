//
//  HTUpdateInfoModel.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTUpdateInfoModel.h"

@implementation HTUpdateInfoModel

- (void)updateInfo:(NSString *)uid name:(NSString *)name avatar:(NSString *)avatar height:(NSString *)height sex:(int)sex birthday:(NSString *)birthday device:(NSString *)device coachTel:(NSString *)coachTel
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:8];
  [parameters setValue:uid forKey:@"uid"];
  [parameters setValue:name forKey:@"nick"];
  [parameters setValue:height forKey:@"height"];
  [parameters setValue:[NSNumber numberWithInt:sex] forKey:@"sex"];
  [parameters setValue:avatar forKey:@"avatar"];
  [parameters setValue:@"" forKey:@"device"];
  [parameters setValue:coachTel forKey:@"coachTel"];

//  [parameters setValue:birthday forKey:@"birthday"];
  [self uploadImage:@"api/user/UpdateInfo" parameters:parameters image:[UIImage imageNamed:@"upload_pic.png"] imageName:@"pic"];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
  return [[UserResponse alloc] initWithDictionary:responseDict error:error];
}

@end
