//
//  SendCodeModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "SendCodeModelHandler.h"

@implementation SendCodeModelHandler

- (id)initWithController:(HTBaseViewController<SendCodeModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<SendCodeModelProtocol> *controller = (HTBaseViewController<SendCodeModelProtocol>*)self.controller;
  [controller sendCodeFinished:data];
}

@end
