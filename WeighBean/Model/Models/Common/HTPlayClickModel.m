//
//  HTPlayClickModel.m
//  HereTravel
//
//  Created by liumadu on 15/7/1.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTPlayClickModel.h"

@implementation HTPlayClickModel

//type: 1：城市介绍，2：景点详情，3：特产详情，4：感动瞬间详情，5：说走就走详情；6:景区详情
- (void)playClick:(int)tid type:(int)type
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [parameters setValue:[NSNumber numberWithInt:tid] forKey:@"id"];
  [parameters setValue:[NSNumber numberWithInt:type] forKey:@"type"];
  [self getPath:@"/play_click.htm" parameters:parameters];
}

@end
