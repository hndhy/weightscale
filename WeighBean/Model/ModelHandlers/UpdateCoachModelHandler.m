//
//  UpdateCoachModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "UpdateCoachModelHandler.h"

@implementation UpdateCoachModelHandler
- (id)initWithController:(HTBaseViewController<UpdateCoachModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<UpdateCoachModelProtocol> *controller = (HTBaseViewController<UpdateCoachModelProtocol>*)self.controller;
    [controller updateCoachFinished:(UpdateCoachResponse *)data];
}
@end
