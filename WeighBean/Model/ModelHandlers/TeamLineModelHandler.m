//
//  TeamLineModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "TeamLineModelHandler.h"

@implementation TeamLineModelHandler
- (id)initWithController:(HTBaseViewController<TeamLineModelProtocol> *)controller;
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<TeamLineModelProtocol> *controller = (HTBaseViewController<TeamLineModelProtocol>*)self.controller;
    [controller syncFinished:(TeamLineResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<TeamLineModelProtocol> *controller = (HTBaseViewController<TeamLineModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<TeamLineModelProtocol> *controller = (HTBaseViewController<TeamLineModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<TeamLineModelProtocol> *controller = (HTBaseViewController<TeamLineModelProtocol>*)self.controller;
    [controller syncFailure];
}

@end
