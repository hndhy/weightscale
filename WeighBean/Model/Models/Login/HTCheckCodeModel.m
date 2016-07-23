//
//  HTCheckCodeModel.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTCheckCodeModel.h"

@implementation HTCheckCodeModel

- (void)checkCode:(NSString *)code phone:(NSString *)phone
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:phone forKey:@"tel"];
  [parameters setValue:code forKey:@"qcode"];
  [self getPath:@"/checkQcodeWithTel.htm" parameters:parameters];
}

@end
