//
//  VerifyOrderHander.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "VerifyOrderHander.h"

@implementation VerifyOrderHander


- (id)initWithController:(HTBaseViewController<VerifyOrderModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<VerifyOrderModelProtocol> *controller = (HTBaseViewController<VerifyOrderModelProtocol>*)self.controller;
    [controller syncFinished:(VerfiyOrderResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<VerifyOrderModelProtocol> *controller = (HTBaseViewController<VerifyOrderModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<VerifyOrderModelProtocol> *controller = (HTBaseViewController<VerifyOrderModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<VerifyOrderModelProtocol> *controller = (HTBaseViewController<VerifyOrderModelProtocol>*)self.controller;
    [controller syncFailure];
}


@end
