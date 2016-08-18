//
//  SyncDataListResponse.h
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "SyncBodyData.h"

@interface SyncDataListResponse : BaseResponse

@property(nonatomic, strong) NSArray<SyncBodyData> *results;

@property(nonatomic, strong) NSArray<SyncBodyData> *delResults;
@property(nonatomic, copy) NSString *lastSync;

@end
