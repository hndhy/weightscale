//
//  PersonalListModel.m
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "PersonalListModel.h"
#import "HTAppContext.h"

@implementation PersonalListModel
- (void)getPersonalListWithUid:(NSString *)uid
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
//    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:uid forKey:@"uid"];
    [self getPath:@"api/user/MyDakaDynamic" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[PersonalListResponse alloc] initWithDictionary:responseDict error:error];
}

@end
