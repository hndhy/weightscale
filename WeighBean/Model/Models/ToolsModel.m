//
//  ToolsModel.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/29.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "ToolsModel.h"
#import "HTAppContext.h"
#import "ToolsResponse.h"

@implementation ToolsModel

- (void)getTools
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    NSLog(@"parameters = %@",parameters);
    [self getPath:@"/vtoolMain.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[ToolsResponse alloc] initWithDictionary:responseDict error:error];
}

@end
