//
//  JoinCoachModel.m
//  WeighBean
//
//  Created by sealband on 16/8/11.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JoinCoachModel.h"

@implementation JoinCoachModel
- (void)joinCoachWithUid:(NSString *)uid teamID:(NSString *)tid;
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:6];
    [parameters setValue:uid forKey:@"fromUid"];
    [parameters setValue:tid forKey:@"tid"];
    [self getPath:@"api/team/JoinTeam" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[JoinCoachResponse alloc] initWithDictionary:responseDict error:error];
}
@end
