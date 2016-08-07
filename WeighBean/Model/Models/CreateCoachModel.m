//
//  CreateCoachModel.m
//  WeighBean
//
//  Created by sealband on 16/8/6.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CreateCoachModel.h"

@implementation CreateCoachModel
- (void)creatCoachWithUid:(NSString *)uid teamType:(int)teamType teamName:(NSString *)teamName isChat:(int)isChat description:(NSString *)description target:(NSString *)target
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:6];
    [parameters setValue:uid forKey:@"fromUid"];
    [parameters setValue:@(teamType) forKey:@"teamType"];
    [parameters setValue:teamName forKey:@"teamName"];
    [parameters setValue:@(isChat) forKey:@"isChat"];
    [parameters setValue:description forKey:@"description"];
//    [parameters setValue:target forKey:@"target"];
    [self getPath:@"api/team/Create" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[CreateCoachResponse alloc] initWithDictionary:responseDict error:error];
}@end
