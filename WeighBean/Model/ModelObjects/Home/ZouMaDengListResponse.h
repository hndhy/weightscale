//
//  ZouMaDengListResponse.h
//  WeighBean
//
//  Created by liumadu on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"

#import "ZouMaDengInfoModel.h"

@interface ZouMaDengListResponse : BaseResponse

@property (nonatomic, strong) NSArray<ZouMaDengInfoModel> *results;

@end
