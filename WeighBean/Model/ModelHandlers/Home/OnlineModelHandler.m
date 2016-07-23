//
//  OnlineModelHandler.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "OnlineModelHandler.h"

@implementation OnlineModelHandler

- (id)initWithController:(HTBaseViewController<OnlineModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<OnlineModelProtocol> *controller = (HTBaseViewController<OnlineModelProtocol>*)self.controller;
    [controller syncFinished:(OnlineListResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<OnlineModelProtocol> *controller = (HTBaseViewController<OnlineModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<OnlineModelProtocol> *controller = (HTBaseViewController<OnlineModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<OnlineModelProtocol> *controller = (HTBaseViewController<OnlineModelProtocol>*)self.controller;
    [controller syncFailure];
}

@end
