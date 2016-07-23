//
//  NotifNumberModel.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/26.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "NotifNumberModel.h"
#import "HTAppContext.h"
#import "NotifNumberResponse.h"

@implementation NotifNumberModel

- (void)getNotifNumber
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    NSLog(@"parameters = %@",parameters);
    [self getPath:@"/noticeNumber.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[NotifNumberResponse alloc] initWithDictionary:responseDict error:error];
}

@end
