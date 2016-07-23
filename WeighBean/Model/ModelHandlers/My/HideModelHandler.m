//
//  HideModelHandler.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/8.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HideModelHandler.h"

@implementation HideModelHandler

- (id)initWithController:(HTBaseViewController<HideModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<HideModelProtocol> *controller = (HTBaseViewController<HideModelProtocol>*)self.controller;
    [controller syncFinished:(HideModelResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<HideModelProtocol> *controller = (HTBaseViewController<HideModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<HideModelProtocol> *controller = (HTBaseViewController<HideModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<HideModelProtocol> *controller = (HTBaseViewController<HideModelProtocol>*)self.controller;
    [controller syncFailure];
}

@end
