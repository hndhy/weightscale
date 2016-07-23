//
//  HTSendCodeModel.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTSendCodeModel.h"

@implementation HTSendCodeModel

- (void)sendCode:(NSString *)phone type:(NSString *)type
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:phone forKey:@"tel"];
  [parameters setValue:type forKey:@"type"];
  [self getPath:@"/getQcodeByTel.htm" parameters:parameters];
}

@end
