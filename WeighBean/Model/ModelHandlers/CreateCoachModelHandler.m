//
//  CreateCoachModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/6.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CreateCoachModelHandler.h"

@implementation CreateCoachModelHandler

- (id)initWithController:(HTBaseViewController<CreateCoachModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<CreateCoachModelProtocol> *controller = (HTBaseViewController<CreateCoachModelProtocol>*)self.controller;
    [controller createCoachFinished:(CreateCoachResponse *)data];
}
@end
