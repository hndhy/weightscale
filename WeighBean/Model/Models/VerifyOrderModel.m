//
//  VerifyOrderModel.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "VerifyOrderModel.h"
#import "HTAppContext.h"

@implementation VerifyOrderModel

- (void)getProductid:(NSString *)pid
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:pid forKey:@"pid"];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    NSLog(@"parameters = %@",parameters);
    [self getPath:@"/DetailProduct.htm" parameters:parameters];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[VerfiyOrderResponse alloc] initWithDictionary:responseDict error:error];
}

@end
