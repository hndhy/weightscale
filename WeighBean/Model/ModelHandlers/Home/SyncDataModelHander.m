//
//  SyncDataModelHander.m
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "SyncDataModelHander.h"

@implementation SyncDataModelHander

- (id)initWithController:(HTBaseViewController<SyncModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<SyncModelProtocol> *controller = (HTBaseViewController<SyncModelProtocol>*)self.controller;
    [controller syncFinished:(SyncDataListResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
  [super netError:sender error:error];
  HTBaseViewController<SyncModelProtocol> *controller = (HTBaseViewController<SyncModelProtocol>*)self.controller;
  [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
  [super parseError:sender error:error];
  HTBaseViewController<SyncModelProtocol> *controller = (HTBaseViewController<SyncModelProtocol>*)self.controller;
  [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
  [super resultError:sender data:data];
  HTBaseViewController<SyncModelProtocol> *controller = (HTBaseViewController<SyncModelProtocol>*)self.controller;
  [controller syncFailure];
}

@end
