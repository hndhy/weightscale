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
- (void)getTeamLisetInfo
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:@"9951B02C-ADC0-AF9D-6378-F5374A5DCBB3" forKey:@"tid"];
    [self getPath:@"api/team/TeamsDynamic" parameters:parameters];

}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[TeamLineResponse alloc] initWithDictionary:responseDict error:error];
}

@end
