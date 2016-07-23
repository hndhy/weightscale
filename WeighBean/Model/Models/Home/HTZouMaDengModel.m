//
//  HTZouMaDengModel.m
//  WeighBean
//
//  Created by liumadu on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTZouMaDengModel.h"

#import "HTAppContext.h"

@implementation HTZouMaDengModel

- (void)getZouMaDeng
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:@"ios" forKey:@"os"];
  HTAppContext *appContext = [HTAppContext sharedContext];
  [parameters setValue:appContext.uid forKey:@"uid"];
  [self getPath:@"syncData_Zoumadeng.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
  return [[ZouMaDengListResponse alloc] initWithDictionary:responseDict error:error];
}

@end
