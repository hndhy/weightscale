//
//  HTMyInfoModel.m
//  WeighBean
//
//  Created by liumadu on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTMyInfoModel.h"

@implementation HTMyInfoModel

- (void)getMyInfo:(NSString *)uid
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:uid forKey:@"uid"];
  [self getPath:@"/getMyInfo.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
  return [[UserResponse alloc] initWithDictionary:responseDict error:error];
}

@end
