//
//  MeasureInfoModel.m
//  WeighBean
//
//  Created by liumadu on 15/8/12.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "MeasureInfoModel.h"

@implementation MeasureInfoModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([@"boneMass" isEqualToString:propertyName]) {
        return YES;
    }
    return NO;
}

@end
