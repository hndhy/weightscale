//
//  AddLookResponse.m
//  WeighBean
//
//  Created by 曾宪东 on 15/9/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "AddLookResponse.h"

@implementation AddLookResponse

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([@"userExist" isEqualToString:propertyName]) {
        return YES;
    }
    return NO;
}

@end
