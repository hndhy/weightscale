//
//  TeamListModel.m
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "TeamListModel.h"
#import "HTAppContext.h"
@implementation TeamListModel
- (void)getTeamLisetInfoWithTeamID:(NSString *)teamID offset:(NSString *)offset
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:teamID forKey:@"tid"];
    [parameters setValue:@"10" forKey:@"count"];
    [parameters setValue:offset forKey:@"start"];
    [self getPath:@"api/team/TeamsDynamic" parameters:parameters];

}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[TeamLineResponse alloc] initWithDictionary:responseDict error:error];
}

@end
