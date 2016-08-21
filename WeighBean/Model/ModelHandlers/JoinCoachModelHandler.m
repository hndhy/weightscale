//
//  JoinCoachModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/11.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JoinCoachModelHandler.h"

@implementation JoinCoachModelHandler
- (id)initWithController:(HTBaseViewController<JoinCoachModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<JoinCoachModelProtocol> *controller = (HTBaseViewController<JoinCoachModelProtocol>*)self.controller;
    [controller JoinCoachFinished:(JoinCoachResponse *)data];
}
@end
