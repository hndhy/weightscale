//
//  ViewCoachDetailModel.m
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "ViewCoachDetailModel.h"

@implementation ViewCoachDetailModel
- (void)viewCoachDetailWithUid:(NSString *)uid
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:6];
    [parameters setValue:uid forKey:@"fromUid"];
    [self getPath:@"api/team/TeamInfo" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[ViewCoachDetailResponse alloc] initWithDictionary:responseDict error:error];
}
@end
