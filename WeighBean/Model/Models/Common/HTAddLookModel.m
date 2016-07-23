//
//  HTAddLookModel.m
//  WeighBean
//
//  Created by 曾宪东 on 15/9/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAddLookModel.h"
#import "HTAppContext.h"
#import "AddLookResponse.h"

@implementation HTAddLookModel

- (void)searchChengYan:(NSString *)tel
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:@"ios" forKey:@"os"];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    [parameters setValue:tel forKey:@"tel"];
    [self getPath:@"/searchUnderUser.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[AddLookResponse alloc] initWithDictionary:responseDict error:error];
}

- (void)joinMyTeamId:(NSString *)uid;
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:@"ios" forKey:@"os"];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    [parameters setValue:uid forKey:@"underUid"];
    [self getPath:@"/joinMyTeam.htm" parameters:parameters];
}

@end
