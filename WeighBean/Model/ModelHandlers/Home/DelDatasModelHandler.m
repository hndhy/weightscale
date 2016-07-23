//
//  DelDatasModelHandler.m
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "DelDatasModelHandler.h"

@implementation DelDatasModelHandler

- (id)initWithController:(HTBaseViewController<DelDatasModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<DelDatasModelProtocol> *controller = (HTBaseViewController<DelDatasModelProtocol>*)self.controller;
    [controller delFinished:(BaseResponse *)data];
}

@end
