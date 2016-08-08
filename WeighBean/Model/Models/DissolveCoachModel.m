//
//  DissolveCoachModel.m
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "DissolveCoachModel.h"

@implementation DissolveCoachModel

- (void)dissolveCoachWithUid:(NSString *)uid teamID:(NSString *)tid
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:6];
    [parameters setValue:uid forKey:@"fromUid"];
    [parameters setValue:tid forKey:@"tid"];
    [self getPath:@"api/team/ReleaseTeam" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[DissolveCoachResponse alloc] initWithDictionary:responseDict error:error];
}
@end
