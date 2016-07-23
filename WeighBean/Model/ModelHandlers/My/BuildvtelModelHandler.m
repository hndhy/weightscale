//
//  BuildvtelModelHandler.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/13.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "BuildvtelModelHandler.h"

@implementation BuildvtelModelHandler

- (id)initWithController:(HTBaseViewController<BuildvtelModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<BuildvtelModelProtocol> *controller = (HTBaseViewController<BuildvtelModelProtocol>*)self.controller;
    [controller syncFinished:(BuildvtelResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<BuildvtelModelProtocol> *controller = (HTBaseViewController<BuildvtelModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<BuildvtelModelProtocol> *controller = (HTBaseViewController<BuildvtelModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<BuildvtelModelProtocol> *controller = (HTBaseViewController<BuildvtelModelProtocol>*)self.controller;
    [controller syncFailure];
}
@end
