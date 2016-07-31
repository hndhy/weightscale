//
//  NSDictionary+GetValue.m
//  WeighBean
//
//  Created by sealband on 16/7/31.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "NSDictionary+GetValue.h"

@implementation NSDictionary (GetValue)
- (id)getValueForKey:(NSString *)_key
{
    id obj= [self valueForKey:_key];
    if ([obj isKindOfClass:[NSNull class]] || ([obj isKindOfClass:[NSString class]] && ([obj length] == 0 || [obj isEqualToString:@"(null)"]))) {
        return nil;
    }
    return obj;
}

- (id)getValueForKeyPath:(NSString *)_path
{
    id obj= [self valueForKeyPath:_path];
    if ([obj isKindOfClass:[NSNull class]] || ([obj isKindOfClass:[NSString class]] && ([obj length] == 0 || [obj isEqualToString:@"(null)"]))) {
        return nil;
    }
    return obj;
}

@end
