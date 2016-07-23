//
//  HideModel.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/8.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HideModel.h"
#import "HTUserData.h"

@implementation HideModel

- (void)getHideStatus
{
    HTUserData *user = [HTUserData sharedInstance];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:user.uid forKey:@"uid"];
    [self getPath:@"/getStatVal.htm" parameters:parameters];
}

- (void)setHideStatus:(NSString *)status
{
    HTUserData *user = [HTUserData sharedInstance];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:user.uid forKey:@"uid"];
    [parameters setValue:status forKey:@"stat"];
    [self getPath:@"/hideme.htm" parameters:parameters];
}

- (HideModelResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[HideModelResponse alloc] initWithDictionary:responseDict error:error];
}

@end
