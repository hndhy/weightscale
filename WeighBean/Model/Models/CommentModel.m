//
//  CommentModel.m
//  WeighBean
//
//  Created by sealband on 16/8/29.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CommentModel.h"
#import "HTAppContext.h"

@implementation CommentModel
- (void)postCommentWithDakaID:(NSString *)dakaID author:(NSString *)author comment:(NSString *)comment
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:dakaID forKey:@"dakaid"];
    [parameters setValue:author forKey:@"author"];
    [parameters setValue:comment forKey:@"content"];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    [parameters setValue:@1 forKey:@"type"];

    [self getPath:@"api/user/DakaComment" parameters:parameters];
}


- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[CommentResponse alloc] initWithDictionary:responseDict error:error];
}
@end
