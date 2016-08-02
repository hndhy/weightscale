//
//  UserResponse.m
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UserResponse.h"
#import "NSDictionary+GetValue.h"

@implementation UserResponse

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  if ([@"isFresh" isEqualToString:propertyName]) {
    return YES;
  }
  return NO;
}

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.data = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
    return self;
}

- (int) age
{
    return [[self.data getValueForKey:@"age"] intValue];
}
- (NSString *) avatar
{
    return [self.data getValueForKey:@"avatar"];
}
- (NSString *) birthday
{
    return [self.data getValueForKey:@"birthday"];
}
- (NSString *) coachTel
{
    return [self.data getValueForKey:@"coachTel"];
}
- (NSString *) device
{
    return [self.data getValueForKey:@"device"];
}
- (int) height
{
    return [[self.data getValueForKey:@"height"] intValue];
}
- (BOOL) isCoach
{
    return [self.data getValueForKey:@"isCoach"];
}
- (NSString *) nick
{
    return [self.data getValueForKey:@"nick"];
}
- (int) sex
{
    return [[self.data getValueForKey:@"sex"] intValue];
}
- (NSString *)tel
{
    return [self.data getValueForKey:@"tel"];
}
- (NSString *)uid
{
    return [self.data getValueForKey:@"uid"];
}
- (BOOL) isFresh
{
    return [self.data getValueForKey:@"isFresh"];
}

@end
