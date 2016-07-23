//
//  ZouMaDengModelHandler.m
//  WeighBean
//
//  Created by liumadu on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "ZouMaDengModelHandler.h"

@implementation ZouMaDengModelHandler

- (id)initWithController:(HTBaseViewController<ZouMaDengModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<ZouMaDengModelProtocol> *controller = (HTBaseViewController<ZouMaDengModelProtocol>*)self.controller;
  [controller getZouMaDengFinished:(ZouMaDengListResponse *)data];
}

@end
