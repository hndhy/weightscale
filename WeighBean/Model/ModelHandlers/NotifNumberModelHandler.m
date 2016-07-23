//
//  NotifNumberModelHandler.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/26.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "NotifNumberModelHandler.h"

@implementation NotifNumberModelHandler


- (id)initWithController:(HTBaseViewController<NotifNumberModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<NotifNumberModelProtocol> *controller = (HTBaseViewController<NotifNumberModelProtocol>*)self.controller;
    [controller syncFinished:(NotifNumberResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<NotifNumberModelProtocol> *controller = (HTBaseViewController<NotifNumberModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<NotifNumberModelProtocol> *controller = (HTBaseViewController<NotifNumberModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<NotifNumberModelProtocol> *controller = (HTBaseViewController<NotifNumberModelProtocol>*)self.controller;
    [controller syncFailure];
}


@end
