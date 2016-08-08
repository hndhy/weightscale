//
//  UpdateCoachModel.m
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "UpdateCoachModel.h"

@implementation UpdateCoachModel
- (void)udpateCoachWithUid:(NSString *)uid teamID:(NSString *)tid teamName:(NSString *)teamName isChat:(int)isChat description:(NSString *)description
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:6];
    [parameters setValue:uid forKey:@"uid"];
    [parameters setValue:tid forKey:@"tid"];
    [parameters setValue:teamName forKey:@"teamName"];
    [parameters setValue:@(isChat) forKey:@"isChat"];
    [parameters setValue:description forKey:@"description"];
    [self getPath:@"api/team/Update" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[UpdateCoachResponse alloc] initWithDictionary:responseDict error:error];
}

@end
