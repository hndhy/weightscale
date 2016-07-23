//
//  State.m
//  WeighBean
//
//  Created by liumadu on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "State.h"

@implementation State

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.text = @"";
    self.color = [UIColor clearColor];
  }
  return self;
}

@end
