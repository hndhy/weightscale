//
//  DissolveCoachModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "DissolveCoachModelHandler.h"

@implementation DissolveCoachModelHandler
- (id)initWithController:(HTBaseViewController<DissolveCoachModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<DissolveCoachModelProtocol> *controller = (HTBaseViewController<DissolveCoachModelProtocol>*)self.controller;
    [controller dissolveCoachFinished:(DissolveCoachResponse *)data];
}
@end
