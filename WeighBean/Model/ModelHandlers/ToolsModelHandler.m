//
//  ToolsModelHandler.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/29.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "ToolsModelHandler.h"

@implementation ToolsModelHandler

- (id)initWithController:(HTBaseViewController<ToolsModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<ToolsModelProtocol> *controller = (HTBaseViewController<ToolsModelProtocol>*)self.controller;
    [controller syncFinished:(ToolsResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<ToolsModelProtocol> *controller = (HTBaseViewController<ToolsModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<ToolsModelProtocol> *controller = (HTBaseViewController<ToolsModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<ToolsModelProtocol> *controller = (HTBaseViewController<ToolsModelProtocol>*)self.controller;
    [controller syncFailure];
}


@end
