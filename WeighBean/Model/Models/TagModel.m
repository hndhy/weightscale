//
//  TagModel.m
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "TagModel.h"
#import "HTAppContext.h"

@implementation TagModel
- (void)getTagList;
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    [self getPath:@"api/data/DakaTagList" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[TagResponse alloc] initWithDictionary:responseDict error:error];
}

@end
