//
//  CoachModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/7/31.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachModelHandler.h"

@implementation CoachModelHandler

- (id)initWithController:(HTBaseViewController<CoachModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<CoachModelProtocol> *controller = (HTBaseViewController<CoachModelProtocol>*)self.controller;
    [controller syncFinished:(CoachListResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<CoachModelProtocol> *controller = (HTBaseViewController<CoachModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<CoachModelProtocol> *controller = (HTBaseViewController<CoachModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<CoachModelProtocol> *controller = (HTBaseViewController<CoachModelProtocol>*)self.controller;
    [controller syncFailure];
}

@end
