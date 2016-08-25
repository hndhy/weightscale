//
//  JournalModel.m
//  WeighBean
//
//  Created by sealband on 16/8/25.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JournalModel.h"
#import "HTAppContext.h"
#import "JournalResponse.h"

@implementation JournalModel
- (void)getJournalWithStarttime:(NSString *)startTime endTime:(NSString *)endTime pageCount:(NSString *)pageCount starPage:(int)startPage
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    [parameters setValue:startTime forKey:@"startTime"];
    [parameters setValue:endTime forKey:@"endTime"];
    [parameters setValue:pageCount forKey:@"count"];
    [parameters setValue:@(startPage) forKey:@"start"];
  
    [self getPath:@"api/user/GetDakaInDate" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[JournalResponse alloc] initWithDictionary:responseDict error:error];
}
@end
