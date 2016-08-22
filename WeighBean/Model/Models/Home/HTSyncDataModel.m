//
//  HTSyncDataModel.m
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTSyncDataModel.h"
#import "SyncDataListResponse.h"
#import "HTUserData.h"
#import "UserResponse.h"

@implementation HTSyncDataModel

- (void)syncData:(NSString *)lastSyncTime withData:(NSString*)data
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    HTUserData *userDate = [HTUserData sharedInstance];
    [parameters setValue:userDate.uid forKey:@"UID"];
    [parameters setValue:lastSyncTime forKey:@"lastSync"];
    [parameters setValue:data forKey:@"data"];
    [parameters setValue:userDate.token forKey:@"token"];

    [self getPath:@"api/data/SyncData" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[SyncDataListResponse alloc] initWithDictionary:responseDict error:error];
}

@end
