//
//  HTCheckTelAndNickModel.m
//  WeighBean
//
//  Created by liumadu on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTCheckTelAndNickModel.h"

@implementation HTCheckTelAndNickModel

- (void)checkTel:(NSString *)tel nickName:(NSString *)nickName
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:tel forKey:@"tel"];
  [parameters setValue:nickName forKey:@"nick"];
  [self getPath:@"/checkTelAndNick.htm" parameters:parameters];
}

//- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
//{
//  return [[UploadAvatarResponse alloc] initWithDictionary:responseDict error:error];
//}

@end
