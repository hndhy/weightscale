//
//  SyncDataModelHander.h
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@class SyncDataListResponse;

@protocol SyncModelProtocol <NSObject>

- (void)syncFinished:(SyncDataListResponse *)response;
- (void)syncFailure;

@end

@interface SyncDataModelHander : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<SyncModelProtocol> *)controller;

@end
