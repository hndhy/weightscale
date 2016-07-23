//
//  BaseResponse.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <JSONModel.h>

@interface BaseResponse : JSONModel

@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *msg;

+ (void)initKeyMapper;

@end
