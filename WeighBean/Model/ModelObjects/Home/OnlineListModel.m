//
//  OnlineListModel.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "OnlineListModel.h"
#import "HTAppContext.h"

@implementation OnlineListModel

- (void)getOnlineListPage:(NSInteger )page
{
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
//    [parameters setValue:pageStr forKey:@"page"];
//    HTAppContext *appContext = [HTAppContext sharedContext];
//    [parameters setValue:appContext.uid forKey:@"uid"];
//    NSLog(@"parameters = %@",parameters);
    [self getPath:@"api/data/ListProduct" parameters:nil];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[OnlineListResponse alloc] initWithDictionary:responseDict error:error];
}

@end
