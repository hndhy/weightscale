//
//  ViewCoachDetailModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "ViewCoachDetailModelHandler.h"

@implementation ViewCoachDetailModelHandler
- (id)initWithController:(HTBaseViewController<ViewCoachDetailModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<ViewCoachDetailModelProtocol> *controller = (HTBaseViewController<ViewCoachDetailModelProtocol>*)self.controller;
    [controller viewCoachDetailFinished:(ViewCoachDetailResponse *)data];
}
@end
