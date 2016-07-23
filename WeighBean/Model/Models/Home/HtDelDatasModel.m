//
//  HtDelDatasModel.m
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HtDelDatasModel.h"
#import "BaseResponse.h"
#import "HTAppContext.h"

@implementation HtDelDatasModel

- (void)delDatas:(NSString *)measureTimes
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:measureTimes forKey:@"measureTimes"];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    NSLog(@"parameters = %@",parameters);
//    [self uploadImage:@"/delData.htm" parameters:parameters image:[UIImage imageNamed:@"upload_pic.png"] imageName:@"pic"];
    [self getPath:@"/delData.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[BaseResponse alloc] initWithDictionary:responseDict error:error];
}

@end
