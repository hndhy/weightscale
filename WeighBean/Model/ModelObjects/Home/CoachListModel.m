//
//  CoachListModel.m
//  WeighBean
//
//  Created by sealband on 16/7/31.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachListModel.h"
#import "HTAppContext.h"

@implementation CoachListModel

- (void)getCoachListPage:(NSInteger )page
{
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
//    [parameters setValue:pageStr forKey:@"page"];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    NSLog(@"parameters = %@",parameters);
    [self getPath:@"/List.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[CoachListResponse alloc] initWithDictionary:responseDict error:error];
}

@end
