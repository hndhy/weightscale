//
//  TrendObjModel.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/10.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "TrendObjModel.h"
#import "TrendResponse.h"

@implementation TrendObjModel

- (void)getFristDataWithUid:(NSString *)uid
{
    if (uid.length)
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
        
        [parameters setValue:uid forKey:@"uid"];
        NSLog(@"parameters = %@",parameters);
        [self getPath:@"/getDataByUid.htm" parameters:parameters];
    }
}

- (void)getMoreWithUid:(NSString *)uid lastId:(NSString *)lastid
{
    if (uid.length && lastid)
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
        
        [parameters setValue:uid forKey:@"uid"];
        [parameters setValue:lastid forKey:@"stamp"];
        NSLog(@"parameters = %@",parameters);
        [self getPath:@"/getDataByUid.htm" parameters:parameters];
    }
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[TrendResponse alloc] initWithDictionary:responseDict error:error];
}

@end
