//
//  BuildvtelModel.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/13.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "BuildvtelModel.h"

@implementation BuildvtelModel

- (void)randomtel
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [self getPath:@"/buildvtel.htm" parameters:parameters];
}

- (BuildvtelResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[BuildvtelResponse alloc] initWithDictionary:responseDict error:error];
}

@end
