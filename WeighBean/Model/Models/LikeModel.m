//
//  LikeModel.m
//  WeighBean
//
//  Created by sealband on 16/8/27.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "LikeModel.h"

@implementation LikeModel
- (void)postLikeWithPicID:(NSString *)picID
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:picID forKey:@"dakaid"];
    [self getPath:@"api/user/Praise" parameters:parameters];
}


- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[LikeResponse alloc] initWithDictionary:responseDict error:error];
}
@end
